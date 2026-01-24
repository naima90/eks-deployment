module "vpc" {
  source = "./modules/vpc"

  project_name    = var.project_name
  cidr_block      = var.cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  cluster_name    = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.private_subnets
  project_name = var.cluster_name

}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  cluster_name = var.cluster_name

  depends_on = [module.eks]

}
