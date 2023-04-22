resource "aws_security_group" "postgres" {
  name        = "postgres"
  description = "defines access to flight-booking db"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "postgres_ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.postgres.id
  source_security_group_id = aws_security_group.lambda.id
}

resource "aws_security_group" "lambda" {
  name        = "flight-booking-lambda"
  description = "defines sg for lambda"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "lambda_egress" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lambda.id
  source_security_group_id = aws_security_group.postgres.id
}

resource "aws_security_group_rule" "lambda_egress_internet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lambda.id
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "alb" {
  name        = "alb"
  description = "allow access to alb"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_to_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "egress_ecs_from_alb" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = aws_security_group.fargate_pool.id
}

resource "aws_security_group_rule" "ingress_alb_to_fargate_pool" {
  description              = "inbound trafic from alb"
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.fargate_pool.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group" "fargate_pool" {
  name        = "fargate_pool"
  description = "allow access to Fargate instances"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "egress_fargate" {
  type              = "egress"
  description       = "allow any destination"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.fargate_pool.id
}

resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc_endpoint"
  description = "defines access for vpc_endpoint"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "vpc_endpoint_fargate" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.vpc_endpoint.id
  source_security_group_id = aws_security_group.fargate_pool.id
}

resource "aws_security_group_rule" "vpc_endpoint_fargate_ingress" {
  type              = "ingress"
  description       = "allow any destination"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_endpoint.id
}

resource "aws_security_group_rule" "postgres_ingress_fargate" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.postgres.id
  source_security_group_id = aws_security_group.fargate_pool.id
}
