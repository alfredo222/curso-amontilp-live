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
    key = "users/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "users" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/curso-amontilp-terraform-modules//users?ref=master" #"../../../modules/users"
    
  # General variables
  environment = "lab"
  project = "day08"
  resource_prefix = "amontilp"
  users_list = ["amontilp01","amontilp02","amontilp03"] 
  group_name = "amontilp-developers"
  policies_list = ["AWSCodeCommitPowerUser","CloudWatchReadOnlyAccess"]
}