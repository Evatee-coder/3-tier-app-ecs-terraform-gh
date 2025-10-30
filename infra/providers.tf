terraform {
  required_version = "1.13.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    # template = {
    #   source  = "hashicorp/template"
    #   version = "2.2.0" # Update this to a compatible version
    # }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Using S3 backend
terraform {
  backend "s3" {
  }
}