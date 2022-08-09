terraform {
  backend "s3" {
    bucket = "tf-states-ephemeral-env"
    key = "tf-api-gateway/tf-api-gateway.tfstate"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
