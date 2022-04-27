# IMPORTANT

## This is a continuation of docker-demo-1

## Where we created a repository and built and pushed the docker image to it...

## THE terraform.tfstate file in this folder was copied from docker-demo-1

- so that terraform sees that we already created this ecr.tf (repository)

  ***

Now that our app was dockerized and uploaded to ECR in docker-demo-1

We can start the ECS cluster up.

ECS: EC2 Container services will manage our docker containers.

## A list of the latest ECS AMIs can be found at:

https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-ami-versions.html

Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
