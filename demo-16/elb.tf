resource "aws_elb" "my-elb" {
  name            = "my-elb"

  # We will have a Load balancer in each subnet.
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  
  # Typically allowing port 80 (http) and 443 (ssl)
  # In this example, we not defining secure traffic, only http traffic which goes over port 80
  security_groups = [aws_security_group.elb-securitygroup.id]
  
  # port mapping - mapping LB port 80 to instance port 80 since out application will be running on port 80 in the instance
  # but could map LB port 80 to instance port 5000 for example
  listener {
    lb_port           = 80 # any incoming traffic on port 80 will be forwarded to the instance port which is also 80
    lb_protocol       = "http" # any incoming traffic on port 80 will be forwarded to the instance port which is also 80
    
    instance_port     = 80 # this instance port could be anything, i.e. could be port 5000 if you have a nodejs app running
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2 # if a new instance is added it needs to have at least 2 healthy checks before LB will send traffic to it
    unhealthy_threshold = 2 # if an active instance has two unhealthy checks, then the LB will not send more traffic to this instance
    timeout             = 3
    target              = "HTTP:80/" # here we check on port 80 the slash which will do a GET on the main website running on an instance to see if the main page is healthy
    interval            = 30 # check every 30 seconds if instance is healthy
  }

  # if a user hits the LB in main-public-2, it can still be routed to the ec2 instance in main-public-1
  cross_zone_load_balancing   = true 
  
  # If we're going to remove an ec2 instance 400 seconds, because there still might be active connections,
  # so only after 400 seconds remove the instance
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}

