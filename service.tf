
module "service" {
  source  = "github.com/philips-software/terraform-aws-ecs-service"

  environment = "${var.environment}"
  project = "${var.project}"
  tags = "${var.tags}"

  enable_monitoring = false
  
  
  ecs_cluster_id = "${module.ecs_cluster.id}"
  ecs_cluster_name = "${module.ecs_cluster.name}"
  
  docker_image = "nginxdemos/hello"
  service_name = "test"

  #
  # EFS volume
  #
  volumes = [{
    name      = "${var.efs["docker_volume"]}"
    host_path = "${var.efs["ecs_mountpoint"]}"
  }]
  docker_mount_points = <<EOF
    "mountPoints": [
      {
        "readOnly": null,
        "containerPath": "${var.efs["docker_mountpoint"]}",
        "sourceVolume": "${var.efs["docker_volume"]}"
      }
    ]
  EOF
  

  
  // ALB specific settings
  ecs_service_role      = "${module.ecs_cluster.service_role_name}"
  enable_alb            = true
  internal_alb          = false // or true if it's only used in the vpc
  vpc_id                = "${module.vpc.vpc_id}"
  subnet_ids            = "${join(",", module.vpc.public_subnets)}"
  alb_certificate_arn   = "${var.certificate_arn}"
  container_ssl_enabled = false // or true if the container has SSL enabled
  container_port        = "80"
  alb_port              = "443"

  // DNS specifc settings for the ALB
  enable_dns            = true
  dns_name              = "web-${var.environment}.${module.vpc.private_domain_name}" // Leave blank to disable creation of DNS record
  dns_zone_id           = "${module.vpc.private_dns_zone_id}"

  # // Monitoring settings
  # monitoring_sns_topic_arn = "${aws_sns_topic.monitoring.arn}"

  # // All settings below are optional
  # container_cpu = "1024"
  # container_memory = "2048"

  # desired_count = "1"

  # docker_environment_vars = <<EOF
  #   { "name": "VAR_X", "value": "value" }
  # EOF

  # // Enables logging to other targets (default is STDOUT)
  # // For CloudWatch logging, make sure the awslogs-group exists
  # docker_logging_config = <<EOF
  #   "logConfiguration": {
  #     "logDriver": "awslogs",
  #     "options": {
  #       "awslogs-group": "test-logs",
  #       "awslogs-region": "eu-west-1"
  #     }
  #   }
  # EOF

}

