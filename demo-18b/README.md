# In each folder - dev and prod folders:

`ssh-keygen -f mykey`

`terraform init`

`terraform apply`

`terraform destroy`

---

# Using Two Seperate aws accounts instead of just one for prod and dev

I'm interested to have two separate account for dev and prod env. How can I do it? You mentioned the "profile" in the video but i'm not so sure how to go about it.

You can configure 2 AWS credentials using profiles:

aws --profile x configure

aws -profile y configure

This will configure 2 profiles in ~/.aws/credentials

You can now use profile x or profile y in the providers.tf in terraform.

---

Hi, I have created 2 users

`aws --profile dev configure`

`aws --profile prod configure`

Can you give an example of how to use one of them in providers.tf please?

---

provider "aws" {
...
profile = "dev"
}

provider "aws" {
...
profile = "prod"
}

---

Just using profile = "dev" and profile ="prod" indeed.
