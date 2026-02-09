variable "name" {
  type = string
  description = "Nazwa deploymentu"
  default = "testapp"
}

variable "namespace" {
  type = set(string)
  description = "Namespace, gdzie ma wylądować aplikacja"
  default = ["app1","app2"]
}

variable "image" {
  type = string
  description = "Obraz w ECR"
  default = "441728895705.dkr.ecr.eu-central-1.amazonaws.com/app/testapp:v1"
}

variable "replicas" {
  type = number
  description = "Ile replik (HA -> min 2)"
  default = 2
}

variable "labels" {
  type = map(string)
  description = "Labelki podów (potem użyjesz ich w selector Service)"
  default = {
    app = "testapp"
  }
}

variable "container_port" {
  type = number
  description = "Port na którym słucha aplikacja w kontenerze"
  default = 80
}

variable "service_port" {
  type    = number
  default = 80
}
