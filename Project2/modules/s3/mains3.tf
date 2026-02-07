resource "aws_s3_bucket" "S3" {
    bucket = var.name
    tags = var.tags
}