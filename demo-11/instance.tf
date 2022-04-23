# THIS AN EXAMPLE INSTANCE - IT WONT WORK PROPERLY
# AS ITS MISSING VARS / VPC / SECURITY GROUPS etc
# SEE DEMO-8 FOR A WORKING EXAMPLE


resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet where this instance will be launched
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name



# This is the part of relevance - we are adding a static private 
# IP address to this instance... otherwise it would be dynamic 
# (a new one selected each time the instance starts)
  private_ip = "10.0.1.4" # within the range of the subnet main-public-1
}

# HERE we are also adding a static public IP address to this instance
resource "aws_eip" "example-eip" {
    instance = aws_instance.example.id
    vpc = true
}

# EIP stands for Elastic IP address - this is a public static IP address

output "ip" {
  value = aws_eip.example-eip.public_ip
}

# SO NOW THIS INSTANCE HAS A STATIC PRIVATE IP AND A 
# STATIC PUBLIC IP :-)