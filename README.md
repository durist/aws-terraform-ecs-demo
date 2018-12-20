# aws-terraform-ecs-demo

Simple demo of web container that serves https

This needs a cert; see README in /certs directory.

# SSHing to bastion/EC2 nodes

Need to get IPs of ec2 nodes from console

## To get ip of bastion:
`terraform output -module=bastion`

## Add key to ssh-agent
`ssh-add /path/to/private_key`

## SSH to bastion host
`ssh ec2-user@<bastion-ip>`

## SSH through bastion host to ec2 node
`ssh -o ProxyCommand='ssh -W %h:%p ec2-user@<bastion-ip>' ec2-user@<target-ip>`
