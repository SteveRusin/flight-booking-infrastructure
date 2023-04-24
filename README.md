# Flight Booking aws infrastructure

This repo contains terraform modules for flight booking project infrastructure

## Prerequisite

- Terraform >= v1.3.7
- AWS CLI v2

## Project installation instructions

1. Clone the project
1. Login to aws using aws cli.
1. If you using non default aws account refer to [Using no default aws account](#using-no-default-aws-account) step before proceeding
1. Copy and rename `variables.private.example` -> `variables.private.tf` and provide variable values
1. Run `terraform init`
1. Define infrastructure and apply using `terraform plan/apply` commands

## Using no default aws account
1. Copy and rename `.env.example` -> `.env` and define aws account details
1. Source `.env` file using `. ./source-env.sh` command

## Knows issues

- State file is defined locally. Todo use s3 backend to share state file
- Infrastructure code is not production ready. It's missing environments like nprod/prod. This should be handled by terragrunt and folder structure
- Terragrunt and Atlantis is not integrated
- ECS image is hardcoded. Todo use blue/green deployment approach
- Tests for infrastructure is missing

## Architecture diagram
[Flight booking architecture diagram](./flight_booking.architecture.png)

## Module structure

- Each module is defined in separate folder
- Module contains:
  - `main.tf` - main entry file for module. Core module logic is written here
  - `variables.tf` - module inputs
  - `output.tf` - module outputs
  - `locals.tf` - module locals
  - if needed additional files could be defined which supports module and helps to be DRY e.g `iam.tf`, `event-bridge.tf`. See `lambda` folder

## Modules
- `alb` - defines load balancer and other required resources
- `db` - defines postgres database and other required resources
- `ecr` - defines elastic container registry
- `ecs` - defines elastic container service and other required resources
- `frontend` - defines s3 for frontend and other required resources
- `lambda` - defines flight info aggregate lambda and other required resources
- `security-groups` - defines security groups. Moved to separate module to avoid cross module dependency
- `vpc` - defines virtual private cloud with subnets and other required resources
- `vpc_endpoint` - vpc endpoints. Currently only endpoints for ecs

## Other files
- `main.tf` - project main entry point
- `provider.tf` - defines required providers
- `source-env.sh` - script used to export not default aws account. Refer to [Using no default aws account](#using-no-default-aws-account)
- `ecr-login.sh` - script to login into ecr
