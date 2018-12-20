data "template_file" "ecs-instance-user-data" {
  template = "${file("${path.module}/user-data-ecs-cluster-instance.tpl")}"

  vars {
    ecs_cluster_name = "${module.ecs_cluster.name}"
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

  user_data = "${data.template_file.ecs-instance-user-data.rendered}"
}

# locals {
#   service_name = "blog"
# }
