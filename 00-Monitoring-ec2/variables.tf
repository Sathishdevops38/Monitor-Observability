variable "project_name"{
    default = "roboshop"
}
variable "environment"{
    default = "dev"
}

variable "grafana_tags"{
    default ={
        createdby = "terraform"
        usage =  "monitor"
    }
}

variable "prometheus_tags"{
    default ={
        createdby = "terraform"
        usage =  "monitor"
    }
}

variable "instance_type"{
    default = "t3.micro"
}
