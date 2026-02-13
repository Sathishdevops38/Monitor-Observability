terraform {
    required_providers{
      aws = {
        source = "hashicorp/aws"
        version = "6.16.0"
      }
    }
    backend "s3"{
        bucket = "terraform-backend-86"
        key    = "roboshop-datadog"
        region = "us-west-2"
        use_lockfile = true
    }
}

provider "aws"{
    region = "us-west-2"
}