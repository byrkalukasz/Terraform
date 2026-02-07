variable "name" {
  description = "Nazwa Bucketa"
  type = string
}

variable "tags" {
    description = "Tagi dla s3"
    type = map(string)  
}