resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.flight-info-aggregate-lambda.function_name}"
  retention_in_days = 7

  lifecycle {
    prevent_destroy = false
  }
}
