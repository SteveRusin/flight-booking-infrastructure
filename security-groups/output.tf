output "db_seg_group_id" {
  value = aws_security_group.postgres.id
}

output "lambda_seg_group_id" {
  value = aws_security_group.lambda.id
}

output "vpc_endpoint_sg_id" {
  value = aws_security_group.vpc_endpoint.id
}

output "fargate_pool_sg_id" {
  value = aws_security_group.fargate_pool.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}
