module "efs" {
  source  = "github.com/philips-software/terraform-aws-efs"
  
  environment = "${var.environment}"
  project = "${var.project}"
  tags = "${var.tags}"

  mount_location = "${var.efs["ecs_mountpoint"]}"
  
  vpc_id = "${module.vpc.vpc_id}"
  subnet_ids = "${module.vpc.private_subnets}"

  # NONE OF THESE WORK, GRRR
  #subnet_count = "${length(module.vpc.private_subnets)}"
  #subnet_count = "${length(var.aws_azs.default."${var.aws_region}")}"
  #subnet_count = "${length(lookup(var.aws_azs[default]["${var.aws_region}"]))}"
  
  subnet_count = "${var.subnet_count}"
}
