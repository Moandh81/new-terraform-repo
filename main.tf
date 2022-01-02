terraform {



backend "remote" {
    hostname = "app.terraform.io"
    organization = "my-simple-organisation"

    workspaces {
      name = "new-terraform-repo"
    }
  }



  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


provider "aws" {

  profile = "default"
  region  = "eu-west-3"

}


# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
# }


# resource "aws_instance" "app_server" {


#   ami           = "ami-0c6ebbd55ab05f070"
#   instance_type = "t2.micro"
#   count = var.instance_count
#   key_name = "adminkey"



#   tags = {
#     "Name" = var.instance_name
#   }


# }



module "iam_user" {

    source = "./modules/iam_user"
    iam_user_name = "user-from-terraform"
    

}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-0c6ebbd55ab05f070"
  instance_type          = "t2.micro"
  key_name               = "adminkey"
  count                  = var.instance_count

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}