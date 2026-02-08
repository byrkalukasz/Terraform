variable "env" {
    type = string
    default = "test"
}

variable "pools" {
    type = any
    default = { 
    linpool = { 
      instance_types = ["t3a.small"] 
      capacity_type = "ON_DEMAND" 
      min_size = 2 
      max_size = 4 
      desired_size = 2 
      labels = { 
        pool = "Linpool" 
        os = "Linux" 
        } 
      } 
    linspot = {
      instance_types = ["t3a.small"] 
      capacity_type = "SPOT" 
      min_size = 0 
      max_size = 2 
      desired_size = 0 
      labels = { 
        pool = "Linspot" 
        os = "Linux" 
        } 
        } 
        }
}