locals {
  common_name_suffix = "${var.projectname}-${var.environment}"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.myami.id
  tg_port = "${var.component}" == "frontend" ? 80 : 8080
  contenx = "${var.component}" == "frontend" ? "/" : "/health"
  zone_id = data.aws_route53_zone.zone_id.id
  alb_listern_arn = data.aws_ssm_parameter.alb_listener_arn.value
  frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
  sg_id = data.aws_ssm_parameter.sg_id.value
  listener_arn = "${var.component}" == "frontend" ? frontend_listener_arn : alb_listern_arn
  host_header = "${var.component}" == "frontend" ? "${var.projectname}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
  private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  common_tags = {
    Project = var.projectname
    Environment = var.environment
    Terraform = "true"
}
}

