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
    key = "s3/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "s3" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/curso-amontilp-terraform-modules//s3?ref=master" #"../../../modules/users"
    
  # General variables
  environment = "lab"
  project = "day08"
  resource_prefix = "amontilp"
  bucketName = "amontilp-bucket-data"
  version_enabled = true
  file_list = {
    "file01.txt" = {
        source  = "resources/file01.txt"
        key    = "/datosBucket/file01.txt" 
    },
    "file02.txt" = {
        source  = "resources/file02.txt"
        key    = "/datosBucket/file02.txt" 
    },
    "file03.txt" = {
        source  = "resources/file03.txt"
        key    = "/datosBucket/file03.txt" 
    }
  }
}

#Seccion para exportar variables
output "s3_bucket_name" {
  description = "nombre del bucket s3"
  value = module.s3.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "s3 bucket arn info"
  value = module.s3.s3_bucket_arn
}