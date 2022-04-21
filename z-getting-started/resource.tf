# provider "aws" {

# }

# variable "AWS_REGION" {
#     type = string
#     default = "us-east-1"
# }

# variable "AMIS" {
#     type = map(string)
#     default = {
#         eu-west-1 = "my ami"
#     }
# }

# resource "aws_instance" "example1" {
#   ami = var.AMIS[var.AWS_REGION]
#   instance_type = "t2.micro"
# }
# resource "aws_instance" "example2" {
#   ami = var.AMIS[var.AWS_REGION]
#   instance_type = "t2.small"
# }
# resource "aws_instance" "example3" {
#   ami = var.AMIS[var.AWS_REGION]
#   instance_type = "t2.big"
# }

/* 
    terraform init (to get the deps)

    terraform console
 */