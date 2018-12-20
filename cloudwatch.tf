module "cloudwatch" {
  source = "github.com/philips-software/terraform-aws-cloudwatch"

  environment = "${var.environment}"
  name_suffix = "${var.project}"
  tags = "${var.tags}"
}

# # Assemble cloud init config.
# data "template_cloudinit_config" "config" {

#   part {
#     content_type = "${module.cloudwatch.amazon_linux_cloudinit_ecs_part["content_type"]}"
#     content      = "${module.cloudwatch.amazon_linux_cloudinit_ecs_part["content"]}"
#   }

#   part {
#     content_type = "${module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content_type"]}"
#     content      = "${module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content"]}"
#   }

#   ... some other parts ...
#   part {
#     ...
#   }
#   ... some other parts ...

# }
