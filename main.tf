module "vpc" {
  source = "./modules/vpc"
  env = var.env
  vpc_cidr = var.vpc_cidr
  azs = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  account_number = var.account_number
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
}
