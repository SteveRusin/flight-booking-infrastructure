variable "cron_schedule" {
  type    = string
  default = "rate(1 hour)"
}
variable "lambda_seg_group_id" {
  type = string
}
variable "private_lambda_subnet_id" {
  type = object({
    a = string
    b = string
    c = string
  })
}

variable "datasource_providers" {
  type = string
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

variable "db_password" {
  type = string
}
