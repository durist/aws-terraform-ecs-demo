
# Prefixed to all resources
variable "environment" {
  default = "dev"
}
provider "aws" {
  region     = "us-east-1"
}
data "aws_region" "current" {}

# FIXME interpolate from path?
variable "project" {
  default = "aws-terraform-simple"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_azs" {
  default = {
    us-east-1 = [
      "us-east-1a",
      "us-east-1b",
    ]
  }
}
# FIXME need to use this in efs module, due to broken dependency resolution in v0.11
variable "subnet_count" { default = 2 }


variable "key_name" {
  default = "durist-dev"
}

variable "enable_bastion" {
  default = true
}

variable "tags" {
  default = {
    # FIXME interpolate from somewhere?
    Owner = "durist"
  }
}

variable "ecs_cluster" {
  default = {
    instance_type = "t2.micro"
    min_count = 1
    max_count = 1
    desired_count = 1
  }

}

variable "certificate_arn" {
  # dev-artifactory.ucar.edu
  default = "arn:aws:acm:us-east-1:865407926015:certificate/e89882b7-888a-4a00-b9bc-c9df35403d92"
}


