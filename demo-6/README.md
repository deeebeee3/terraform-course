First do:

ssh-keygen -f mykey

---

`terraform init`
to get the providers

---

To Run this module you need to do

`terraform get`

to first to connect to the github repo specified in the modules.tf
and download this module in terraform.

---

`terraform init` will add the providers inside the `.terraform` folder
`terraform get` will add the downloaded module inside the `.terraform` folder

A .terraform.lock.hcl gets generated when you do `terraform init`

---

In this particular example we create a cluster of 3 ec2 instances.

In each case an instance is created, and then provisioned.

At the end of the `terraform apply` finished running we chose to output the cluster host ip address:

`````Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

consul-output = "ec2-54-74-176-188.eu-west-1.compute.amazonaws.com"````

---

We could ssh to this host and have a look at the consul cluster if necessary...

`````

`terraform destroy`
