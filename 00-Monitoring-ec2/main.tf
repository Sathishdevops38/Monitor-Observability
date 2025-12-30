module "grafana" {  
  source = "git::https://github.com/Sathishdevops38/terraform-modules.git//20-bastion-module?ref=main"
  project_name = var.project_name
  environment = var.environment
  subnet_id = local.subnet_id  
  instance_type = var.instance_type
  sg_ids =   [local.sg_id]
  iam_profile_name = aws_iam_instance_profile.role.name
  root_volume_size = 50
  root_volume_type = "gp3"

  user_data = file("grafana.sh")
  tags= merge(
    var.grafana_tags,
    local.common_tags,{
      Name =  "${local.common_name_suffix}-grafana"
    }
  )  
}

resource "aws_iam_instance_profile" "role" {
  name = "grafana"
  role = "EC2FullAccessMonitor"
}

resource "aws_vpc_security_group_ingress_rule" "grafana" {
  security_group_id = local.sg_id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "all_access" {
  security_group_id = local.sg_id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all inbound traffic from IPv4"
}

module "prometheus" {  
  source = "git::https://github.com/Sathishdevops38/terraform-modules.git//20-bastion-module?ref=main"
  project_name = var.project_name
  environment = var.environment
  subnet_id = local.subnet_id  
  instance_type = var.instance_type
  sg_ids =   [local.sg_id]
  iam_profile_name = aws_iam_instance_profile.role.name
  root_volume_size = 50
  root_volume_type = "gp3"

  user_data = file("prometheus.sh")
  tags= merge(
    var.prometheus_tags,
    local.common_tags,{
      Name =  "${local.common_name_suffix}-prometheus"
    }
  )  
}