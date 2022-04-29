# This if for the security group that will be attached to the ECS instance
resource "aws_security_group" "ecs-securitygroup" {
  vpc_id      = aws_vpc.main.id
  name        = "ecs"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.myapp-elb-securitygroup.id]
    # We allow port 3000 only from the ELB (load balancer)
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # should change this to my own IP address
  }
  tags = {
    Name = "ecs"
  }
}

# This if for the security group for the load balancer
resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id      = aws_vpc.main.id
  name        = "myapp-elb"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # we will be allowing port 80 which is the default http port, for everyone
  }
  tags = {
    Name = "myapp-elb"
  }
}

