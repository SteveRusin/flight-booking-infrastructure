resource "aws_db_instance" "flight-booking" {
  allocated_storage      = 20
#  identifier             = "flight_booking_database"
  db_name                = "flight_booking"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.instance_class
  username               = "useradmin"
  db_subnet_group_name   = var.aws_db_subnet_group_name
  password               = random_password.db_pwd.result
  vpc_security_group_ids = [var.db_seg_group_id]
  skip_final_snapshot    = true
}


resource "random_password" "db_pwd" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "db_pwd" {
  name        = "/flight-booking/dbpassw"
  description = "password to flight-booking db"
  type        = "SecureString"
  value       = random_password.db_pwd.result
}
