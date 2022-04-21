# Declaring variables for use
variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

# Declaring variables for use and setting default values
variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    us-west-2 = "ami-09a2a0f7d2db8baca"
    eu-west-1 = "ami-0f29c8402f8cce65c"
  }
}

/* https://cloud-images.ubuntu.com/locator/ec2/ */

