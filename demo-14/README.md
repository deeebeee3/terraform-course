# IAM Roles

After `terraform apply` - we can check that the ec2 instance assumed the role...

Login to the instance:

`ssh -i mykey ubuntu@xx.xxx.xxx.xxx`

`sudo -s`

Then install AWS Command Line Utilty (we need PIP to install CLI)

`apt-get update`

`apt-get install -y python-pip python-dev`

Install the CLI

`pip install awscli`

---

`aws` - we have the cli

`clear` - clear screen for some room

create a text file
`echo "this is a test" > test.txt`

copy this file to s3
`aws s3 cp test.txt s3://mybucket-c29df1/test.txt`

Upload worked from the instance without logging in to aws from inside the instance... we have access to bucket, we can write to
or download from the bucket

---

So where do the credentials come from for the instance to access the s3 bucket...? From the aws metadata...

We can query this url (its an aws service) to see the metadata:

`curl http://169.254.169.254/latest/meta-data/`

`curl http://169.254.169.254/latest/meta-data/iam/security-credentials/s3-mybucket-role`

`s3-mybucket-role` is the name we gave to the role in the iam.tf file

If we go to that url - we will see the `AccessKeyId` and the `SecretAccessKey`

this is what the instance uses to gain access to the bucket...

This is a much safer way of using AWS services from within
EC2 instances...
