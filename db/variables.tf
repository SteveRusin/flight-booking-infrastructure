variable "vpc_id" {
  type = string
}
variable "db_seg_group_id" {
  type = string
}
variable "aws_db_subnet_group_name" {
  type = string
}

variable "db_engine" {
  type = string
  default = "postgres"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro" #use bigger class for prod
}

variable "db_engine_version" {
  type = string
  default = "14"
}

variable "db_name" {
  type = string
  default = "flight-booking"
}
