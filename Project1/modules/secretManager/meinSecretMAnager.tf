resource "aws_secretsmanager_secret" "secretManagerLB" {
  name = var.name
  tags = var.tags
}