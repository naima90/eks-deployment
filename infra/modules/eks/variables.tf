variable "cluster_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.34"

}

variable "subnet_ids" {
  type = list(string)
}