module "bastion" {
  source  = "github.com/philips-software/terraform-aws-bastion"

  enable_bastion = "${var.enable_bastion}"

  environment = "${var.environment}"
  project     = "${var.project}"
  aws_region  = "${data.aws_region.current.name}"

  key_name = "${var.key_name}"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_id = "${module.vpc.vpc_id}"

  tags = "${var.tags}"
}
