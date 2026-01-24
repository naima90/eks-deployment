module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  cidr_block = var.cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  azs = var.azs
  cluster_name = module.eks.cluster_name
}

module "eks" {
  source = "./modules/eks"

  subnet_ids = module.vpc.private_subnets
  project_name = var.project_name

}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  cluster_name = module.eks.cluster_name

}