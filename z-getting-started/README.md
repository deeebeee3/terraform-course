# TERRAFORM

## IAM

Create IAM user: terraform

Create user-group and add user (can do when creating the user): terraform-admininistrators

Give the user-group admin permissions

—————————————————————

## EC2

Go to EC2

Select region from drop down: eu-west-1 (Ireland)

Go to “security groups” in left menu under Network & Security - click on the security group ID

Add Inbound rule to allow all traffic from myIPAddress

—————————————————————

Edit instance.tf file:

provider "aws" {
access_key = ""
secret_key = ""
region = "eu-west-1"
}

resource "aws_instance" "example" {
ami = "ami-0f29c8402f8cce65c"
instance_type = "t3.micro"
}

—————————————————————

You can get / generate new access / secret key from IAM page and click on the user, and then the security tab…

Get the ami from:

https://cloud-images.ubuntu.com/locator/ec2/

Search for the latest images for my region and also the latest ubuntu version (eu-west-1 xenial)

Use AMI-ID from top row

Save the instance.tf file

`terraform init`
`terraform apply` - then type "yes"

Then go to EC2 (make sure you've selected correct region [eu-west-1] from dropdown, same one we used in out instance.tf file above...)

You will be able to see running instance we just created...

`terraform destroy` - then type "yes" (to destroy the instance after our lab)

—————————————————————

`terraform apply`

Is the same as

`terraform plan -out [file] ; terraform apply [file] ; rm [file]`

`terraform plan -out out.terraform ; terraform apply out.terraform ; rm out.terraform`

—————————————————————
