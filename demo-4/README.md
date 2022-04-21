Go to AWS console

click S3

Create a new bucket

terraform-tfstate-[some random character to make it unique]
terraform-tfstate-287hfh23f

region: choose eu-west-1

Hit create...

Click bucket
Properties -> enable versioning (not necessary but handy)

---

In local terminal:

Install AWS CLI:

`brew install awscli`

`aws configure`

❯ aws configure
AWS Access Key ID [None]: AXXXXXXXXXXX0182
AWS Secret Access Key [None]: XnyAie988herguigheblahblahblah
Default region name [None]: eu-west-1
Default output format [None]:

Amazon saves these credentials at `cat ~/.aws/credentials`

This will allow terraform to login to aws, terrafom will use credentials saved in the file

---

Add the backend.tf file with the s3 bucket information

`terraform init`
`terraform plan`
`terraform apply`

Our state will now be saved to our s3 bucket and not locally.

We can check this from the bucket itself and download the file to inspect if wanted.

`terraform destroy`
