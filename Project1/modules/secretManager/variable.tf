variable "name" {
  description = "Nazwa"
  type = string
}

variable "tags" {
    description = "Tagi"
    type = map(string)  
}