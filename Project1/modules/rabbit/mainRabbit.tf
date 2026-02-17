resource "aws_mq_broker" "rabbitMQ" {
    broker_name = var.name
    engine_type = var.engineType
    engine_version = var.engineVersion
    host_instance_type = var.instanceType
    auto_minor_version_upgrade = true #Wymagane przez AWS
  user {
    username = var.user.username
    password = var.user.password
  }
  tags = var.tags
}