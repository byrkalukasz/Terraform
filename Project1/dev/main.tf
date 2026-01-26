#Przygotowanie profidera
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "poweruser_dev"
  region = "eu-central-1"
}

#Zmienne
variable "env" { type = string }
variable "engineType" { type = string }
variable "engineVersion" { type = string }
variable "engineTinstanceType" { type = string }
variable "userName" { type = string }
variable "password" { type = string }
variable "vpc_name" { type = string }
variable "db_sg_name" { type = string }
variable "auroraEngine" { type = string }
variable "auroraEngineVersion" { type = string }
variable "auroraEngineTinstanceType" { type = string }

#S3 Bucket
module "s3" {
    source = "../modules/s3"
      count  = var.create_bucket ? 1 : 0
    name = "app-${var.env}"
    tags = {
      Name = "test-tf-LB"
      Env = var.env
    }
}

#RabbitMQ
module "rabbitMQ" {
  source = "../modules/rabbit"
  count  = var.create_rabbitmq ? 1 : 0
  name = "app-${var.env}"
  engineType = var.engineType
  engineVersion = var.engineVersion
  instanceType = var.engineTinstanceType
  user = {
    username = var.userName
    password = var.password
  }
}

#Secret Manager
module "secretManager" {
    source = "../modules/secretManager"
    count = var.create_secret_manager ? 1 : 0
    name = "app-${var.env}"
}

#Dane VPC i security group
data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_security_group" "db" {
  filter {
    name   = "tag:Name"
    values = [var.db_sg_name]
  }
  vpc_id = data.aws_vpc.this.id
}

data "aws_db_subnet_group" "aurora" {
  name = var.vpc_name
}

#Hasło dla Aurora
resource "random_password" "db_random" {
  count = var.create_aurora ? 1 : 0
  length  = 24
  special = true
}

#Aurora PostgreSQL
module "aurora"{
  source = "../modules/aurora"
  count = var.create_aurora ? 1 : 0
  name = "app-${var.env}"
  engineType = var.auroraEngine
  engineVersion = var.auroraEngineVersion
  instanceType = var.auroraEngineTinstanceType
  password = random_password.db_random[0].result
  vpc_id = data.aws_vpc.this.id
  db_subnet_group_name = data.aws_db_subnet_group.aurora.name
  db_sg_id = data.aws_security_group.db.id
}

