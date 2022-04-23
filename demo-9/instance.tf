resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet where the instance will be launched
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-west-1a" # subnet where instance launched is eu-west-1a too
  size              = 20 #20GBs
  type              = "gp2"
  #gp2 means general purpose ssd.
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh" # /dev/xvdh is the device name for the ebs volume
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}

output "ip" {
  value = aws_instance.example.public_ip
}

