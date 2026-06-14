terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "gamevault_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "gamevault-vpc"
  }
}

# Subnet
resource "aws_subnet" "gamevault_subnet" {
  vpc_id                  = aws_vpc.gamevault_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "gamevault-subnet"
  }
}

# Security Group
resource "aws_security_group" "gamevault_sg" {
  vpc_id = aws_vpc.gamevault_vpc.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gamevault-sg"
  }
}