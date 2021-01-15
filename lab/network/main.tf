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
    key = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "network" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/curso-amontilp-terraform-modules//network?ref=master" #"../../../modules/users"
    
  # General variables
  environment = "lab"
  project = "day08"
  resource_prefix = "amontilp"

  #Variables de red
  vpcID = "vpc-85d908fc"
  internetGWid = "igw-7bcf0d1d"
  mainRouteTableID = "rtb-40679f38"
}

#Seccion para exportar variables
output "subnet01ID" {
    description = "id subnet01"
    value = module.network.subnet01ID
}

output "subnet02ID" {
    description = "id subnet02"
    value = module.network.subnet02ID
}

output "subnet03ID" {
    description = "id subnet03"
    value = module.network.subnet03ID
}
