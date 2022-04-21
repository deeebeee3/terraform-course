`ssh-keygen -f mykey`

Will generate the following files: mykey (private) and mykey.pub (public).

---

`terraform init`

`terraform apply`

Will provision an ec2 instance with our public key and also the script file.
Then it will connect to ec2 instance from my local machine and execute the script (remote exec).

We can see what happened by looking at the log output in terminal...

For example:

aws_instance.example: Provisioning with 'file'...
aws_instance.example: Provisioning with 'remote-exec'...
aws_instance.example (remote-exec): Connecting to remote host via SSH...
aws_instance.example (remote-exec): Host: 54.246.56.154
aws_instance.example (remote-exec): User: ubuntu
aws_instance.example (remote-exec): Password: false
aws_instance.example (remote-exec): Private key: true
aws_instance.example (remote-exec): Certificate: false
aws_instance.example (remote-exec): SSH Agent: true
aws_instance.example (remote-exec): Checking Host Key: false
aws_instance.example (remote-exec): Target Platform: unix
aws_instance.example (remote-exec): Connected!
aws_instance.example (remote-exec): 0% [Working]
aws_instance.example (remote-exec): Hit:1 http://eu-west

The script file we copied and executed - installs and start Nginx.

So if you go to Host: 54.246.56.154 in browser, we will see nginx web server running :-)

Finally afterwards

`terraform destroy`

yes...
