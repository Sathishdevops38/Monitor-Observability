# resource "aws_instance" "windows" {
#   ami = local.ami_id
#   instance_type = var.instance_type
#   security_groups = [local.sg_id]
#   subnet_id = local.subnet_id
#   key_name      = "mypem"
#   get_password_data = true
#   tags= merge(
#     local.common_tags,{
#       Name =  "${local.common_name_suffix}-datadog"
#     }
#   )  
# }


resource "aws_instance" "linux" {
  ami = local.linux_ami_id
  instance_type = var.instance_type
  security_groups = [local.sg_id]
  subnet_id = local.subnet_id
  tags= merge(
    local.common_tags,{
      Name =  "${local.common_name_suffix}-datadog"
    }
  )  
}


