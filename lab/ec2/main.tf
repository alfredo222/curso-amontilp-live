terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "amontilp-bucket"
    key = "ec2/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "ec2" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/curso-amontilp-terraform-modules//ec2?ref=master" #"../../../modules/users"
    
  # General variables
  environment = "lab"
  project = "day08"
  resource_prefix = "amontilp"

  #Variables de red
  vpc_id = "vpc-85d908fc"
  ami_id = "ami-01720b5f421cf0179"
  subnet_id = "subnet-0068e5464f0c1f2c3"
  instance_type = "t2.micro"
  key_name = "./resources/keysday08.pub"
}
