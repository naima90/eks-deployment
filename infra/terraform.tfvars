region       = "eu-west-2"
project_name = "eks-app"
cluster_name = "eks-app-cluster"

cidr_block = "10.0.0.0/16"
azs        = ["eu-west-2a", "eu-west-2b"]

public_subnets = {
  "public-a" = { cidr_block = "10.0.1.0/24", az_index = 0 }
  "public-b" = { cidr_block = "10.0.2.0/24", az_index = 1 }
}
private_subnets = {
  "private-a" = { cidr_block = "10.0.11.0/24", az_index = 0 }
  "private-b" = { cidr_block = "10.0.12.0/24", az_index = 1 }
}

