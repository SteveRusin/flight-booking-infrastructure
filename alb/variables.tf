variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "subnet_id" {
  type = object({
    a = string
    b = string
    c = string
  })
}
