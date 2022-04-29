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

`terraform init`

or

`terraform init -upgrade`

---

0. `ssh-keygen -f mykey`

1. ecs.tf - launch configuration for CLUSTER and autoscaling group
2. iam.tf - iam role policy

3. Task definition (describes what docker container to be run on the cluster)
4. Service definition is going to run a specific amount of containers based on the task definition.

- A Service definition is always running, if container stops it will be restarted.
- A Service definition can be scaled, you can run 1 instance of a container or multiple.
- You can put an Elastic Load Balancer in front of a service.
- You typically run multiple instance of a container spread over Availibility Zones
- If one container fails, your ELB stops sending traffic to it
- Running multiple instances with an ELB/ALB allows us to have High Availibility

5. myapp.tf - 1 Task definition - templates/app.json.tpl is the actual task definition

6. myapp.tf - 2 Service definition - here we define that we want to run the Task definition we defined above as a Service on our example Cluster... We refer to the task definition and we specify how many instances we want to run of this container. We specify iam role (ecs service role). This resource (the service definition) depends on the attachment of the role. The role needs to be created - only then will this resource be created. We specify the Load balancer (the load balancer supports ecs and containers) - we just have to point the load balancer to our myapp container and tell it the container port.

7. myapp.tf - 3 The load balancer (ELB) is defined in this file too

8. output.tf - After terraform apply we will output the dns of the load balancer
   because that will be the point we can access...

9. `terraform apply`

---

if get following error:

Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.

then...

Replace deprecated template_file datasource with templatefile function

see commented old commented out code in myapp.tf

lesson 25...

---

10. example output after `terraform apply` completed:

```
Apply complete! Resources: 27 added, 0 changed, 0 destroyed.

Outputs:

elb = "myapp-elb-1562158763.eu-west-1.elb.amazonaws.com"
```

---

11. Lets login to our instance (our t2.micro that has joined the cluster):
    `ssh -i mykey -l ec2-user 34.255.6.238`

    `sudo -s`

    `cat /etc/ecs/ecs.config` - we can see our ECS_CLUSTER=example-cluster

    `ps aux | grep agent` - agent is running (`ps aux` shows running process and we use `grep` to filter by agent)

    `docker ps` - will see our ecs agent container is running and our nodejs app container is also running.

    `docker ps -a` - This command is used to show all the running and exited containers.

    `curl localhost:3000` - Will see Hello World! output from our nodejs app

    `curl myapp-elb-1562158763.eu-west-1.elb.amazonaws.com` - Will see Hello World! output from our nodejs app

12. Logs

    `tail /var/log/ecs/ecs-agent.log`
