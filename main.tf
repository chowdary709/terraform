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
module "frontend" {
  source        = "./modules/app"
  app_port      = 80
  cidr_blocks   = var.vpc_cidr
  component     = "frontend"
  env           = var.env
  instance_type = "t2.micro"
  subnets       = module.vpc.private_subnets
  vpc_id        = module.vpc.vpc_id
  bastion_node_cidr = var.bastion_node_cidr
}

module "backend" {
  source        = "./modules/app"
  app_port      = 8080
  cidr_blocks   = var.vpc_cidr
  component     = "backend"
  env           = var.env
  instance_type = "t2.micro"
  subnets       = module.vpc.private_subnets
  vpc_id        = module.vpc.vpc_id
  bastion_node_cidr = var.bastion_node_cidr
}
