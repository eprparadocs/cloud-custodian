policies:
 - name: foo
   resource: aws.ec2
   tags:
      - "control1:I"
      - "control2:J"
   description: 
      I, J - No unencrypted/publicly-accessible Redshift allowed
   filters:
    - State: in-use
   actions:
    - type: copy-instance-tags

