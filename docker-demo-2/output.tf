# Lastly we output the dns name for the Load Balancer
# beacuse this is will be the point we can access....
output "elb" {
  value = aws_elb.myapp-elb.dns_name
}
