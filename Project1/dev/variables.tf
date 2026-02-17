variable "create_bucket" {
  type    = bool
  default = false
  description = "Czy tworzyć S3 bucket"
}

variable "create_rabbitmq" {
  type    = bool
  default = false
  description = "Czy tworzyć RabbitMQ broker"
}

variable "create_secret_manager" {
  type    = bool
  default = false
  description = "Czy tworzyć Secret Manager"
}

variable "create_aurora" {
  type    = bool
  default = false
  description = "Czy tworzyć Aurora cluster"
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
