# cluster
resource "aws_ecs_cluster" "example-cluster" {
  name = "example-cluster"
}

resource "aws_launch_configuration" "ecs-example-launchconfig" {
  name_prefix          = "ecs-launchconfig"
  image_id             = var.ECS_AMIS[var.AWS_REGION] # ECS AMIs
  instance_type        = var.ECS_INSTANCE_TYPE # t2.micro
  key_name             = aws_key_pair.mykeypair.key_name

  # Attach a role becuase this EC2 instance needs some extra permissions (mainly ECS and ECR permissions)
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role.id 

  security_groups      = [aws_security_group.ecs-securitygroup.id]

# script to put "ECS_CLUSTER=example-cluster" into ecs.config
# then we start ecs with the ecs.config file: "start ecs"
# Basically we want to launch a cluster that will join the example-cluster we created above
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=example-cluster' > /etc/ecs/ecs.config\nstart ecs"
  
  # if we make any changes to our launch configuration
  # terraform will create the new instance one before destroying the old one
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-example-autoscaling" {
  name                 = "ecs-example-autoscaling"

  # Going to launch this in the public subnet so we can ssh to it from anywhere
  # But safer to launch in a private subnet
  vpc_zone_identifier  = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  
  
  launch_configuration = aws_launch_configuration.ecs-example-launchconfig.name
  
  # this will start one t2.micro instance, but can change it multiple
  # if we want to run multiple instances of a container
  min_size             = 1
  max_size             = 1

  # whenever we launch an instance its going to have "ecs-ec2-container"
  # as the name - we can see in the aws console
  tag {
    key                 = "Name"
    value               = "ecs-ec2-container"
    propagate_at_launch = true
  }
}

