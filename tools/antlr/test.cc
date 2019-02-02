policies:
 - name: foo
   resource: aws.ec2
   filters:
    - State: in-use
   actions:
    - type: copy-instance-tags


