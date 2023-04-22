variable "cron_schedule" {
  type    = string
  default = "cron(* * * * ? *)"
}

variable "lambda_seg_group_id" {}
variable "lambda_access_subnets" {
  type = object({
    a = string
    b = string
    c = string
  })
}

variable "datasource_providers" {
  default = "https://zretmlbsszmm4i35zrihcflchm0ktwwj.lambda-url.eu-central-1.on.aws/provider/flights1,https://zretmlbsszmm4i35zrihcflchm0ktwwj.lambda-url.eu-central-1.on.aws/provider/flights2"
}

variable "db_username" {}
variable "db_name" {}
variable "db_url" {}
