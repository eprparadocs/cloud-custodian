# Copyright 2015-2017 Capital One Services, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
from __future__ import absolute_import, division, print_function, unicode_literals

from c7n.actions import ActionRegistry, BaseAction
from c7n.filters import FilterRegistry, Filter
from c7n.manager import resources
from c7n.query import QueryResourceManager
from c7n.utils import local_session, type_schema


filters = FilterRegistry('xray.filters')
actions = ActionRegistry('xray.actions')


@resources.register('xray')
class Xray(QueryResourceManager):

    class resource_type(object):
        service = 'xray'
        id = name = 'Name'
        dimension = None
        filter_name = None
        enum_spec = ('get_encryption_config', 'EncryptionConfig', None)
        #detail_spec = None

    filter_registry = filters
    action_registry = actions

    def __init__(self, data, options):
        super(Xray, self).__init__(data, options)


@filters.register('encrypt-key')
class XrayEncrypted(Filter):
    """Determine if xray is encrypted.

    :example:

    .. code-block:: yaml

            policies:
              - name: xray-encrypt-with-default
                resource: xray
                filters:
                  - type: encrypt-key
                    key: default
              - name: xray-encrypt-with-kms
                  - type: encrypt-key
                    key: kms
    """

    permissions = ('xray:GetEncryptionConfig',)
    schema = type_schema(
        'encrypt-key',
        required=['key'],
        key={'type': 'string', 'enum': ['default', 'kms']}
    )

    def process(self, resources, event=None):
        import pdb; pdb.set_trace()
        client = local_session(self.manager.session_factory).client('xray')
        xray_type = client.get_encryption_config()['EncryptionConfig']['Type']
        return xray_type == ('KMS' if self.data.get('key') == 'kms' else 'NONE')


@actions.register('xray-encrypt')
class SetXrayEncryption(BaseAction):
    """Enable specific xray encryption.

    :example:

    .. code-block:: yaml

            policies:
              - name: xray-default-encrypt
                resource: xray
                actions:
                  - type: xray-encrypt
                    key: default
              - name: xray-kms-encrypt
                  - type: xray-encrypt
                    key: alias/some/alias/key
    """

    permissions = ('xray:PutEncryptionConfig')
    schema = type_schema(
        'encrypt',
        required=['key'],
        key={'type': 'string'}
    )

    def process(self, resources):
        client = local_session(self.manager.session_factory).client('xray')
        key = self.data.get('key')
        req = {'Type': 'None'} if key == 'default' else {'Type': 'KMS', 'KeyId': key}
        client.put_encryption_config(**req)
