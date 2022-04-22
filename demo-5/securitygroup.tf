# Data that is being pulled from aws containing all the ip ranges.
# We filter it on two regions ["eu-west-1", "eu-central-1"]
# and we specify we only want ec2 services.
data "aws_ip_ranges" "european_ec2" {
  regions  = ["eu-west-1", "eu-central-1"]
  services = ["ec2"]
}

# Here we feed this data to a security group
# data.aws_ip_ranges.european_ec2.cidr_blocks
resource "aws_security_group" "from_europe" {
  name = "from_europe"

  # Here we specify an ingress rule (for incoming traffic).
  # We are only allowing the IPs from the IP ranges datasource defined above
  # to connect to our port 443. cidr means a range of IP addresses.
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.european_ec2.cidr_blocks, 0, 50)
  }

  # Synctoken - if the datasource changes, then this sync token will change
  # Then the next time you run terraform apply, it will update the security group again
  tags = {
    CreateDate = data.aws_ip_ranges.european_ec2.create_date
    SyncToken  = data.aws_ip_ranges.european_ec2.sync_token
  }
}

