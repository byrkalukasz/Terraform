variable "namespaces" {
  description = "Lista namespace'ów do utworzenia"
  type = set(string)
  default = ["platform", "app1", "app2"]
}
