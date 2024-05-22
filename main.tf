module "vpc" {
  source                 = "./modules/vpc"
  env                    = var.env
  vpc_cidr               = var.vpc_cidr
  azs                    = var.azs
  private_subnets        = var.private_subnets
  public_subnets         = var.public_subnets
  account_number         = var.account_number
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr       = var.default_vpc_cidr
  default_route_table_id = var.default_route_table_id
}

module "public-lb" {
  source   = "./modules/alb"
  env      = var.env
  internal = false
  lb_type  = "public"
  subnets  = module.vpc.public_subnets
  vpc_id   = module.vpc.vpc_id
  alb_sg_allow_cidr = "0.0.0.0/0"
}

module "private-lb" {
  source   = "./modules/alb"
  env      = var.env
  internal = true
  lb_type  = "private"
  subnets  = module.vpc.private_subnets
  vpc_id   = module.vpc.vpc_id
  alb_sg_allow_cidr = "0.0.0.0/0"
}
