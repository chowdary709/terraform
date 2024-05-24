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

# module "public-lb" {
#   source            = "./modules/alb"
#   env               = var.env
#   internal          = false
#   lb_type           = "public"
#   subnets           = module.vpc.public_subnets
#   vpc_id            = module.vpc.vpc_id
#   alb_sg_allow_cidr = "0.0.0.0/0"
#   dns_name          = "frontend.${var.env}.roboshop.internal"
#   zone_id           = "Z08360431XA1BOY4SK2N0"
# }

module "private-lb" {
  source            = "./modules/alb"
  env               = var.env
  internal          = true
  lb_type           = "private"
  subnets           = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  alb_sg_allow_cidr = var.vpc_cidr
  dns_name          = "backend-${var.env}.roboshop.internal"
  zone_id           = "Z08360431XA1BOY4SK2N0"
  tg_arn            = module.backend.tg_arn
}
#
# module "frontend" {
#   depends_on        = [module.backend]
#   source            = "./modules/app"
#   app_port          = 80
#   component         = "frontend"
#   env               = var.env
#   instance_type     = "t2.micro"
#   subnets           = module.vpc.private_subnets
#   vpc_id            = module.vpc.vpc_id
#   bastion_node_cidr = var.bastion_node_cidr
#   vpc_cidr          = var.vpc_cidr
#   desired_capacity  = var.desired_capacity
#   max_size          = var.max_size
#   min_size          = var.min_size
# }

module "backend" {
  depends_on        = [module.mysql]
  source            = "./modules/app"
  app_port          = 8080
  component         = "backend"
  env               = var.env
  instance_type     = "t2.micro"
  subnets           = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  bastion_node_cidr = var.bastion_node_cidr
  vpc_cidr          = var.vpc_cidr
  desired_capacity  = var.desired_capacity
  max_size          = var.max_size
  min_size          = var.min_size
}

module "mysql" {
  source         = "./modules/rds"
  component      = "mysql"
  env            = var.env
  vpc_id         = module.vpc.vpc_id
  subnets        = module.vpc.private_subnets
  vpc_cidr       = var.vpc_cidr
  instance_class = var.instance_class
}