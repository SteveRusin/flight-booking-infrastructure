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

  runtime = "nodejs18.x"

  environment {
    variables = {
      DB_HOST     = "localhost"
      DB_PORT     = 5432
      DB_PASSWORD = "admin"
      DATABASE    = "flight-booking"
      DB_USER     = "postgres"
      PROVIDERS   = "https://zretmlbsszmm4i35zrihcflchm0ktwwj.lambda-url.eu-central-1.on.aws/provider/flights1,https://zretmlbsszmm4i35zrihcflchm0ktwwj.lambda-url.eu-central-1.on.aws/provider/flights2"
    }
  }
}
