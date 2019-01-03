data "template_file" "ecs-user-data-base" {
  template = "${file("${path.module}/ecs-user-data-base.tpl")}"

  vars {
    ecs_cluster_name = "${module.ecs_cluster.name}"
  }
}

# REF:
# https://ash.berlintaylor.com/writings/2017/08/reusable-terraform-modules-extending-userdata/
# https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
# Content should end up under /var/lib/cloud
data "template_cloudinit_config" "ecs-user-data" {
  gzip          = true
  base64_encode = true

  # Base cloud config file
  part {
    filename     = "init.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.ecs-user-data-base.rendered}"
  }

  #
  # Optional EFS mount for docker volume
  #
  # FIXME what if we have multiples??? Possible interpolation issues; maybe we can loop
  part {
    filename     = "efs.cfg"
    content_type = "${module.efs.amazon_linux_cloudinit_config_part["content_type"]}"
    content      = "${module.efs.amazon_linux_cloudinit_config_part["content"]}"
  }

}



module "ecs_cluster" {
  source  = "github.com/philips-software/terraform-aws-ecs"

  aws_region  = "${data.aws_region.current.name}"

  environment = "${var.environment}"
  project = "${var.project}"
  tags = "${var.tags}"
  
  key_name = "${var.key_name}"

  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"

  min_instance_count     = "${var.ecs_cluster["min_count"]}"
  max_instance_count     = "${var.ecs_cluster["max_count"]}"
  desired_instance_count = "${var.ecs_cluster["desired_count"]}"
  instance_type          = "${var.ecs_cluster["instance_type"]}"

  subnet_ids = "${join(",", module.vpc.private_subnets)}"

  user_data = "${data.template_cloudinit_config.ecs-user-data.rendered}"
}

# locals {
#   service_name = "blog"
# }
