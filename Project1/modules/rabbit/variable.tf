variable "name" {
  description = "Nazwa"
  type = string
}

variable "engineType" {
  description = "Typ silnika kolejkowego"
  type = string
}

variable "engineVersion" {
  description = "Wersja silnika kolejnowego"
  type = string
}

variable "instanceType" {
    description = "Typ instancji na jakiej robimy deploy"
    type = string      
}

variable "tags" {
    description = "Tagi"
    type = map(string)  
}

variable "user" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}