# resource "aws_cloudwatch_event_rule" "schedule" {
#     name = "schedule"
#     description = "Schedule for Lambda Function"
#     schedule_expression = var.cron_schedule
# }

# resource "aws_cloudwatch_event_target" "schedule_lambda" {
#     rule = aws_cloudwatch_event_rule.schedule.name
#     target_id = "flight-info-aggregate-lambda"
#     arn = aws_lambda_function.flight-info-aggregate-lambda.arn
# }
