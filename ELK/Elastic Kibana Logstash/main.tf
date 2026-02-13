resource "aws_instance" "elk" {
  ami = local.linux_ami_id
  instance_type = var.instance_type
  security_groups = [local.sg_id]
  subnet_id = local.subnet_id
  user_data = file("elk.sh")
  root_block_device {
    volume_size = 60
    volume_type = "gp3"
  }
  # instance_market_options {
  #   market_type = "spot"
  #   spot_options {
  #     # The behavior when a Spot Instance is interrupted (terminate, stop, hibernate)
  #     instance_interruption_behavior = "terminate"
  #     # Optional: The maximum hourly price you're willing to pay (on-demand price is the default if omitted)
  #     # max_price = "0.01" 
  #     # Optional: Request type (one-time or persistent, default is one-time)
  #     # spot_instance_type = "persistent"
  #   }
  # }  
  tags= merge(
    local.common_tags,{
      Name =  "${local.common_name_suffix}-elk"
    }
  )  
}


resource "aws_instance" "nginx_filebeat" {
  ami = local.linux_ami_id
  instance_type = var.instance_type
  security_groups = [local.sg_id]
  subnet_id = local.subnet_id
  user_data = file("filebeat.sh")
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  # instance_market_options {
  #   market_type = "spot"
  #   spot_options {
  #     # The behavior when a Spot Instance is interrupted (terminate, stop, hibernate)
  #     instance_interruption_behavior = "terminate"
  #     # Optional: The maximum hourly price you're willing to pay (on-demand price is the default if omitted)
  #     # max_price = "0.01" 
  #     # Optional: Request type (one-time or persistent, default is one-time)
  #     # spot_instance_type = "persistent"
  #   }
  # }  
  tags= merge(
    local.common_tags,{
      Name =  "${local.common_name_suffix}-filebeat"
    }
  )  
}