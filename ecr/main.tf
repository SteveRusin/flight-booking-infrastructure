resource "aws_ecr_repository" "flight-booking" {
  name                 = "flight-booking"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }
}
