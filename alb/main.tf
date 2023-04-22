resource "aws_lb" "flight_booking_alb" {
  name               = "flightBookingAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = values(var.subnet_id)[*]
}

resource "aws_lb_listener" "flight_booking_app_listener" {
  load_balancer_arn = aws_lb.flight_booking_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flight_booking_ecs.arn
  }
}

resource "aws_lb_listener_rule" "flight_booking_app_rule" {
  listener_arn = aws_lb_listener.flight_booking_app_listener.arn
  priority     = 100

  action {
    type = "forward"

    target_group_arn = aws_lb_target_group.flight_booking_ecs.arn
  }

  condition {
    source_ip {
      values = ["0.0.0.0/0"]
    }
  }
}

resource "aws_lb_target_group" "flight_booking_ecs" {
  name        = "flight-booking-fargate"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = true
    path                = "/healthcheck"
    port                = 3000
    interval            = 60
    unhealthy_threshold = 5
    timeout             = 30
    healthy_threshold   = 5
    matcher             = "200"
  }
}

