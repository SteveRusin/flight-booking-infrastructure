output "db_seg_group_id" {
  value = aws_security_group.postgres.id
}

output "lambda_seg_group_id" {
  value = aws_security_group.lambda.id
}
