variable "vpc_id" {}
variable "db_seg_group_id" {}
variable "aws_db_subnet_group_name" {}

variable "db_engine" {
  default = "postgres"
}

variable "instance_class" {
  default = "db.t3.micro" #use bigger class for prod
}

variable "db_engine_version" {
  default = "14"
}

variable "db_name" {
  default = "flight-booking"
}
