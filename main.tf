module "lambda" {
  source = "./lambda"

  lambda_seg_group_id   = module.security_groups.lambda_seg_group_id
  lambda_access_subnets = module.vpc.private_db_subnet_id
  db_name               = module.db.db_name
  db_url                = module.db.db_url
  db_username           = module.db.db_username
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
