resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0 # allow outgoing traffic from any port
    to_port     = 0 # allow outgoing traffic to any port
    protocol    = "-1" # any protocol
    cidr_blocks = ["0.0.0.0/0"] # all IP addresses
  }

  ingress {
    from_port   = 22 # just allow incoming traffic from port 22
    to_port     = 22 # just allow incoming traffic from port 22
    protocol    = "tcp" # just allow incoming traffic on tcp

    # cidr_blocks = ["0.0.0.0/0"] # allow incoming traffic from any ip

    cidr_blocks = ["80.47.128.181/32"] # My home public IP address slash 32. Slash 32 means theres just one.
  }
  tags = {
    Name = "allow-ssh"
  }
}

