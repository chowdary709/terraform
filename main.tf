module "vpc" {
  source          = "./module/vpc"
  azs             = var.azs
  env             = var.env
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  vpc_cidr        = var.vpc_cidr
}