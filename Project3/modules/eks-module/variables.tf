variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id"{
  type = string
}

variable "name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "nodepools" {
  type = any
}