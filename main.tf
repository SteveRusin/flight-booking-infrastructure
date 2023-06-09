module "lambda" {
  source = "./lambda"

  lambda_seg_group_id      = module.security_groups.lambda_seg_group_id
  private_lambda_subnet_id = module.vpc.private_lambda_subnet_id
  db_name                  = module.db.db_name
  db_url                   = module.db.db_url
  db_username              = module.db.db_username
  db_password              = module.db.db_password
  datasource_providers     = var.datasource_providers
}

module "vpc" {
  source = "./vpc"
}

module "db" {
  source = "./db"

  vpc_id                   = module.vpc.vpc_id
  aws_db_subnet_group_name = module.vpc.aws_db_subnet_group_name
  db_seg_group_id          = module.security_groups.db_seg_group_id
}

module "security_groups" {
  source = "./security-groups"

  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./ecr"
}

module "alb" {
  source = "./alb"

  alb_sg_id = module.security_groups.alb_sg_id
  subnet_id = module.vpc.subnet_id
  vpc_id    = module.vpc.vpc_id
}

module "vpc_endpoint" {
  source = "./vpc_endpoint"

  vpc_id                    = module.vpc.vpc_id
  vpc_endpoint_seg_group_id = module.security_groups.vpc_endpoint_sg_id
  private_ecs_subnet_id     = module.vpc.private_ecs_subnet_id
  private_rt_id             = module.vpc.private_rt_id
}

module "ecs" {
  source = "./ecs"

  alb_ecs_target_group_arn = module.alb.alb_ecs_target_group_arn
  fargate_pool_sg_id       = module.security_groups.fargate_pool_sg_id
  private_ecs_subnet_id    = module.vpc.private_ecs_subnet_id
  db_name                  = module.db.db_name
  db_url                   = module.db.db_url
  db_username              = module.db.db_username
  ecs_initial_image        = var.ecs_initial_image
}

module "frontend" {
  source = "./frontend"
}


output "alb_dns_name" {
  value = module.alb.lb_dns_name
}
