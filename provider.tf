terraform {
  required_version = ">= 1.17.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "YOUR-UNIQUE-TERRAFORM-STATE-BUCKET" 
    key            = "prod/terraform.tfstate"      
    region         = "us-east-1"                         
    dynamodb_table = "YOUR-DYNAMODB-LOCK-TABLE"     
    encrypt        = true                            
    
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::639310891018:role/test_role"
    session_name = "practicesession"
  }
}
