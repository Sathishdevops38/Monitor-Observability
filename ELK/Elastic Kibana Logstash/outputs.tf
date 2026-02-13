output "elk_public_ip" {
  value = aws_instance.elk.public_ip
}

output "filebeat_public_ip" {
  value = aws_instance.elk.public_ip
}