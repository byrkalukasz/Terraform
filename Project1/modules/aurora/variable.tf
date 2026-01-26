variable "name" {
    description = "Nazwa"
    type = string  
}

variable "engineType" {
  default = "aurora-postgresql"
  description = "Typ silnika bazodanowego"
  type = string
}

variable "engineVersion" {
  default = "17.5"
  description = "Wersja silnika"
  type = string
}

variable "instanceType" {
    description = "Rodzaj instancji"
    default = "db.t4g.medium"
    type = string
}

variable "user" {
  description = "Aurora user"
  default = "user"
  type = string
}

variable "password" {
  description = "Aurora password"
  type = string
  sensitive = true
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "db_subnet_group_name" {
  description = "DB Subnet Group Name"
  type = string
}

variable "db_sg_id" {
    description = "Database Security Group ID"
  type = string
}