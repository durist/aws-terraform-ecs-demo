# https://github.com/philips-software/terraform-aws-vpc
module "vpc" {
  source = "github.com/philips-software/terraform-aws-vpc.git"

  environment = "${var.environment}"
  project     = "${var.project}"
  aws_region  = "${data.aws_region.current.name}"
  availability_zones = "${var.aws_azs}" 
  
  // optional, defaults
  #create_private_hosted_zone = "false"  // default = true
  # create_private_subnets     = "false"  // default = true

  tags = "${var.tags}"

}
