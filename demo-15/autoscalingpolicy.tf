# SCALE UP ALARM

resource "aws_autoscaling_policy" "example-cpu-policy-scaleup" {
  name                   = "example-cpu-policy-scaleup"

  #5 This is where we link the policy to the autoscaling group (autoscaling.tf)
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1" #4 scale up by 1 instance
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  #3 We take the average of 2 periods and compare those
  # if they are higher than threshold - then the 
  # above policy will be triggered
  evaluation_periods  = "2" 
  
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120" #2 For more than 120 seconds
  statistic           = "Average"
  threshold           = "30" #1 If this happens (CPU usage %)

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy-scaleup.arn]
}

#--------------------------------------------------------------
#--------------------------------------------------------------

# SCALE DOWN ALARM
resource "aws_autoscaling_policy" "example-cpu-policy-scaledown" {
  name                   = "example-cpu-policy-scaledown"

  #5 This is where we link the policy to the autoscaling group (autoscaling.tf)
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1" #4 scale down by 1 instance
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown" {
  alarm_name          = "example-cpu-alarm-scaledown"
  alarm_description   = "example-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"

  #3 We take the average of 2 periods and compare those
  # if they are lower than threshold - then the 
  # above policy will be triggered
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120" #2 For more than 120 seconds
  statistic           = "Average"
  threshold           = "5" #1 If this happens (CPU usage %)

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy-scaledown.arn]
}

