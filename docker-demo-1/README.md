# ECR and ECS

# 1. Create the ECR Repository

ECR - Elastic container repository
ECS - Elastic container service

`terraform init`
`terraform apply`

will output registry url:

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

myapp-repository-URL = "841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp"
```

Note: 841848180286 is your aws account id which you can alsoe find from the console...

# 2. Build the Docker Image

## cd into docker-demo folder...

`docker build --no-cache -t 841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp:1 .`

`docker build --no-cache -t 841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp .`

-t means we are going to tag this image with a version (:1)

`841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp` - "myapp" is the name of the repository we created earlier.

`"myapp":1 . ` - the dot means we are going to build the current directory

# 3. Push the Docker Image we built up into the ECR Repository

## from within the docker-demo folder...

### 3a. Login into the ECR repository using Docker

CLI Info - commands etc...
\*\*https://docs.aws.amazon.com/cli/latest/reference/#available-services

```
aws ecr get-login-password \
--region <region> \
| docker login \
--username AWS \
--password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

Make sure to fill out the aws accout id, and region (twice):

```
aws ecr get-login-password \
--region eu-west-1 \
| docker login \
--username AWS \
--password-stdin 841848180286.dkr.ecr.eu-west-1.amazonaws.com
```

### 3b. Push the built Docker image to the ECR repository

`docker push 841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp:1`

---

If we go to ECR in AWS we will see our image in the repository...

### Make sure you have the correct region (Ireland eu-west-1) selected from the console dropdown otherwise you wont the repository you created

We can also go to ECS in AWS and click Repositories and will see the uploaded image there too...

---

Next steps will be to run this docker image (spin up container) in ECS...
