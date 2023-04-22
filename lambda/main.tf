data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/flight-info-aggregate-lambda.zip"

  source {
    content  = "exports.handler = () => ({status: 200})"
    filename = "index.js"
  }
}

resource "aws_lambda_function" "flight-info-aggregate-lambda" {
  function_name = "flight-info-aggregate-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  filename      = data.archive_file.dummy.output_path
  timeout       = 45

  runtime = "nodejs18.x"

  vpc_config {
    security_group_ids = [var.lambda_seg_group_id]
    subnet_ids         = [var.lambda_access_subnets.a, var.lambda_access_subnets.b, var.lambda_access_subnets.c]
  }

  environment {
    variables = {
      DB_HOST     = var.db_url
      DB_PORT     = 5432
      DB_PASSWORD = data.aws_ssm_parameter.db_password.value
      DATABASE    = var.db_name
      DB_USER     = var.db_username
      PROVIDERS   = var.datasource_providers
    }
  }
}

data "aws_ssm_parameter" "db_password" {
  name = "/flight-booking/dbpassw"
}
