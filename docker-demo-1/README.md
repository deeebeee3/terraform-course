# ECR and ECS

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

## cd into docker-demo folder...

`docker build -t 841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp:1 .`

-t means we are going to tag this instance with a version (:1)

`841848180286.dkr.ecr.eu-west-1.amazonaws.com/myapp` - "myapp" is the name of the repository we created earlier.

`"myapp":1 . ` - the dot means we are going to build the current directory

---

This will build the docker image and push it up to ECR - if we go to ECR in AWS we will see our image in the repository...

We can also go to ECS in AWS and click Repositories and will see the uploaded image there too...

---

Next steps will be to run this docker image (spin up container) in ECS...
