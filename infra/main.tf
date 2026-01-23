module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  cidr_block = var.cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  azs = var.azs
  cluster_name = var.cluster_name
}