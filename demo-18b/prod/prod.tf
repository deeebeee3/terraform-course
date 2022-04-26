module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "prod"
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "../modules/instances"
  ENV            = "prod"
  VPC_ID         = module.main-vpc.vpc_id  # this is available because we outputted it from the main-vpc module
  PUBLIC_SUBNETS = module.main-vpc.public_subnets  # this is available because we outputted it from the main-vpc module
}

