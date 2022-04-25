resource "aws_security_group" "myinstance" {
  vpc_id      = aws_vpc.main.id
  name        = "myinstance"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # Allow ssh connections from any IP address
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"

    # We caanot access the instances directly on port 80
    ### IMPORTANT - Allow internet traffic (from port 80) only from the Load balancer
    ### IMPORTANT - only the load balancer can access the instance on port 80
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

  tags = {
    Name = "myinstance"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id      = aws_vpc.main.id
  name        = "elb"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # Allow all traffic out
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # Anyone in the world can access this Load balancer on port 80
  }
  tags = {
    Name = "elb"
  }
}

