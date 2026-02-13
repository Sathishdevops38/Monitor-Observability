resource "aws_instance" "prometheus" {
  ami = local.ami_id
  instance_type = var.instance_type
  security_groups = [local.sg_id]
  subnet_id = local.subnet_id

  tags= merge(
    local.common_tags,{
      Name =  "${local.common_name_suffix}-prometheus-grafana"
    }
  )  
}

resource "aws_instance" "member-ec2" {
  ami = local.ami_id
  instance_type = var.instance_type
  security_groups = [local.sg_id]
  subnet_id = local.subnet_id

  tags= merge(
    local.common_tags,{
      Name =  "${local.common_name_suffix}-memec2"
    }
  )
}