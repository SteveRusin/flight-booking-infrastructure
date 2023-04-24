
variable "datasource_providers" {
  default = "http://provder1,http://provider2"
  description = "Comma separated list of providers used by aws lambda to aggregate route info"
}

variable "ecs_initial_image" {
  default = "{acc_id}.dkr.ecr.eu-west-1.amazonaws.com/flight-booking:0.0.1"
  description = "initial image used by ecs. This should be removed. Ecs should pull image from ecr automatically"
}
