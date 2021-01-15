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
    key = "rds/terraform.tfstate"
    region = "eu-west-1"
  }
}

#Para importar datos del modulo network
data "terraform_remote_state" "network" {
  backend = "s3" 
  config = {
    bucket = "amontilp-bucket"
    key = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "rds" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/curso-amontilp-terraform-modules//rds?ref=master" #"../../../modules/users"
    
  # General variables
  environment = "lab"
  project = "day08"
  resource_prefix = "amontilp"

  #Variables de red
  vpcID = "vpc-85d908fc"
  subnet01ID = data.terraform_remote_state.network.outputs.subnet01ID
  subnet02ID = data.terraform_remote_state.network.outputs.subnet02ID
  subnet03ID = data.terraform_remote_state.network.outputs.subnet03ID
}