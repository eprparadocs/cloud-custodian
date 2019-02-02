policies:
 - name: foo
   resource: aws.ec2
   tags:
      - "control1:isrm19"
      - "control2:isrm21"   
   filters:
    - State: in-use
   actions:
    - type: copy-instance-tags





