output "lb_dns_name" {
  value = aws_lb.flight_booking_alb.name
}

output "lb_arn" {
  value = aws_lb.flight_booking_alb.arn
}

output "alb_ecs_target_group_arn" {
  value = aws_lb_target_group.flight_booking_ecs.arn
}
