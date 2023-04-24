resource "aws_ecs_cluster" "flight-booking" {
  name = "flight-booking"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task_def_flight_booking" {
  family                   = "task_def_flight_booking"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.flight_booking.arn
  execution_role_arn       = aws_iam_role.flight_booking.arn
  network_mode             = "awsvpc"
  memory                   = 1024
  cpu                      = 256

  container_definitions = data.template_file.container_definitions.rendered
}

data "template_file" "container_definitions" {
  template = file("${path.module}/container_definition.json")

  vars = {
    # todo image should be pushed from ci/cd
    "ECR_IMAGE"        = var.ecs_initial_image
    "DB_URL"           = var.db_url
    "DB_USER"          = var.db_username
    "DB_NAME"          = var.db_name
    "CLOUDWATCH_GROUP" = aws_cloudwatch_log_group.flight-booking-ecs-logs.name
  }
}

resource "aws_cloudwatch_log_group" "flight-booking-ecs-logs" {
  name = "flight-booking-ecs-logs"
}

resource "aws_ecs_service" "flight-booking" {
  name        = "flight-booking"
  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.task_def_flight_booking.arn
  cluster         = aws_ecs_cluster.flight-booking.id
  desired_count   = 1

  load_balancer {
    target_group_arn = var.alb_ecs_target_group_arn
    container_name   = "task_def_flight_booking"
    container_port   = 3000
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.fargate_pool_sg_id]
    subnets          = [var.private_ecs_subnet_id.a, var.private_ecs_subnet_id.b, var.private_ecs_subnet_id.c]
  }

}

output "template_file" {
  value = data.template_file.container_definitions.rendered
}
