# This is almost the same as our aws_instance resource
# we define in previous lectures
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id]
}


#Here we create our autoscaling group
resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"

  # Here we specify in what subnets we want to launch our instances
  # The first one will br created in aws_subnet.main-public-1
  # The second one (if autoscale policy triggered) will be created 
  # in aws_subnet.main-public-2 for high availibility. 
  # We can add a third public subnet if we want to.
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  
  # This is the launch configuration we created above
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  

  min_size                  = 1 # By default we start up with 1 instance
  max_size                  = 2 # We can scale up to 2 instances

  # If the instance detects that there is a problem with itself
  # then it will be removed from the autoscaling group
  health_check_grace_period = 300 # Normally Load balancer would do healthcheck but in this case we use EC2
  health_check_type         = "EC2" # Normally Load balancer would do healthcheck but in this case we use EC2
  
  #Instances kicked out of the autoscaling group will automatically be deleted
  force_delete              = true 

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

