terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
# Create a VPC
resource "aws_vpc" "main1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Hussain-main"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.main1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PUB-SUB-Hus"
  }
}

resource "aws_subnet" "prvsub" {
  vpc_id     = aws_vpc.main1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PRV-SUB-Hus"
  }
}
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster11"
  role_arn = "arn:aws:iam::539935451710:role/AmazonEKSAutoClusterRole"
  version  = "1.21"
    vpc_config {
    subnet_ids = ["subnet-0f051ab6459f4dd81", "subnet-08509a13a0f791945"] # Specify your subnet IDs
    endpoint_public_access = true
  }
}
resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "my-ecr-repo123" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
