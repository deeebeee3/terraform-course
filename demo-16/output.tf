output "ELB" {
  value = aws_elb.my-elb.dns_name
}

# Host name of the elastic load balancer...

# If we have a website address like deeexample.com
# we can use Route 53 to alias (A record) deeexample.com to the 
# address of the load balancer (for example my-elb.us-east-1.elb.amazonaws.com)


# If we curl a few times 
# curl my-elb.us-east-1.elb.amazonaws.com
# this is: 10.0.2.112
# curl my-elb.us-east-1.elb.amazonaws.com
# this is: 10.0.1.212