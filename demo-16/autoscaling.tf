resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.myinstance.id]


  # The userdata is going to pass a shell script that will install nginx 
  # We're then goin go get the IP address of the instance by executing this command:
  # MYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d '
  # Then we will put 'this is: '$MYIP into a web page: index.html

  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 2 # In this example we want a minimum of 2 instances, so we can clearly see how the load balanceing works
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB" # The load balancer will do the health check, not EC2
  load_balancers            = [aws_elb.my-elb.name] # And here we just specify the load balancer that is going to be used with this autoscaling group
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

