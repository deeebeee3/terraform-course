# Demo 8

ssh-keygen -f mykey

Update the AMIS variable with the latest amazon machine images.

---

After terraform apply

Can get the aws instance public ip address so we can connect to it.

Can either output it to consul, or we can find it in the terraform.tfstate file
Under

`resources: [{type: "aws_instance", instances:[{public_ip: ""}, {}]}, {}, {}`

Then we can connect to aws instance via ssh

ssh 34.241.70.124 -l ubuntu -i mykey

`sudo -s`

`ifconfig`

`route -n`
