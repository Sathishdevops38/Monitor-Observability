variable "project"{
    default = "roboshop"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "instance_type" {
  type = string
  default = "m7i-flex.large"
}