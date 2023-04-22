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
