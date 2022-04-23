resource "aws_route53_zone" "newtech-academy" {
  name = "newtech.academy"
}

# Here we are adding / creating DNS to our ZONE we have created above.
# "server1.newtech.academy" will resolve to "${aws_eip.example-eip.public_ip}"
resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.newtech-academy.zone_id
  name    = "server1.newtech.academy"
  type    = "A"
  ttl     = "300"
  # records = ["104.236.247.8"]

  # THIS IS THE STATIC PUBLIC IP ADDRESS OF THE INSTANCE
  records = ["${aws_eip.example-eip.public_ip}"]
}

# Here we are adding / creating another DNS to our ZONE.
# "www.newtech.academy" will resolve to "${aws_eip.example-eip.public_ip}"
resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.newtech-academy.zone_id
  name    = "www.newtech.academy"
  type    = "A"
  ttl     = "300"
  # records = ["104.236.247.8"]

  # THIS IS THE STATIC PUBLIC IP ADDRESS OF THE INSTANCE
  records = ["${aws_eip.example-eip.public_ip}"]
}

# Here we are adding / creating another DNS to our ZONE.
# This time its an MX (mail server) record

resource "aws_route53_record" "mail1-record" {
  zone_id = aws_route53_zone.newtech-academy.zone_id
  name    = "newtech.academy"
  type    = "MX"
  ttl     = "300"
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
  ]
}

# This will output the name servers to the console.
# We can login to where ever we purchased our domain name from
# and add these nameservers to the domain.
output "ns-servers" {
  value = aws_route53_zone.newtech-academy.name_servers
}

# Route53 has alot of name servers. To output the name servers for 
# our particular domain we can use the output above