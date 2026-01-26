output "db_user" {
  value = module.cluster.cluster_master_username
}

output "db_password" {
  value     = module.cluster.cluster_master_password
  sensitive = true
}
