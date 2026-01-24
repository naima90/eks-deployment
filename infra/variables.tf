variable "region" {
    type = string
}

variable "project_name" {
    type = string
}

variable "cidr_block" {
    type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = map(object({
    cidr_block = string
    az_index   = number
  }))
}

variable "private_subnets" {
    type = map(object({
      cidr_block = string
      az_index = number
    }))
}