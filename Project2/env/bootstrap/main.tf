module "s3" {
    source = "../../modules/s3"
    name = "app-${var.env}-lb"
    tags = {
      Name = "test-tf-LB"
      Env = var.env
    }
}