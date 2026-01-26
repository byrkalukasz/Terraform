module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.0"

  name           = var.name
  engine         = var.engineType
  engine_version = var.engineVersion

  instance_class = var.instanceType
  instances = { one = {} }

  master_username = "appuser"
  master_password = var.password

  vpc_id = var.vpc_id   

  create_db_subnet_group = false
  db_subnet_group_name   = var.db_subnet_group_name

  vpc_security_group_ids = [var.db_sg_id]
  
  skip_final_snapshot = true
}
