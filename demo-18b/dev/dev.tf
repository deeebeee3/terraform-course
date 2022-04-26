module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "dev"
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "../modules/instances"
  ENV            = "dev"
  VPC_ID         = module.main-vpc.vpc_id # this is available because we outputted it from the main-vpc module
  PUBLIC_SUBNETS = module.main-vpc.public_subnets # this is available because we outputted it from the main-vpc module
}

