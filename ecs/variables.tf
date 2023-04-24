variable "alb_ecs_target_group_arn" {
  type = string
}
variable "fargate_pool_sg_id" {
  type = string
}

variable "private_ecs_subnet_id" {
  type = object({
    a = string
    b = string
    c = string
  })
}

variable "db_username" {
  type = string
}
variable "db_name" {
  type = string
}
variable "db_url" {
  type = string
}
variable "ecs_initial_image" {
  type = string
}
