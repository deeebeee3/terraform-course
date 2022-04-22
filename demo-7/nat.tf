# USE A NAT GATEWAY IF YOU WANT TO ALLOW INSTANCES IN PRIVATE SUBNETS
# TO CONNECT TO THE INTERNET, BUT NOT THE OTHER WAY AROUND.
# USEFUL IF YOU HAVE A DATABASE INSTANCE IN A PRIVATE SUBNET, AND YOU WANT IT TO
# BE ABLE TO FETCH UPDATES...

# NAT GATEWAY
# Create a static IP address for the NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
}

# Then use that static IP address to create the NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id

  # "0.0.0.0/0" means all IP addresses except the ones that match the VPC range
  # Those will be routed over the NAT GW
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

# route associations private Subnets
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-3-a" {
  subnet_id      = aws_subnet.main-private-3.id
  route_table_id = aws_route_table.main-private.id
}

