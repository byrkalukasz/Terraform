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
