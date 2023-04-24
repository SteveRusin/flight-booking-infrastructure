variable "vpc_id" {
  type = string
}
variable "vpc_endpoint_seg_group_id" {
  type = string
}
variable "private_ecs_subnet_id" {
  type = object({
    a = string
    b = string
    c = string
  })
}

variable "private_rt_id" { 
  type = string
}
