If we have a website address like deeexample.com
we can use Route 53 to alias (A record) deeexample.com to the
address of the load balancer (for example my-elb.us-east-1.elb.amazonaws.com)

`terraform apply`

If we curl a few times we can see that the load balancer is working...

`curl my-elb.us-east-1.elb.amazonaws.com`
this is: 10.0.2.112

`curl my-elb.us-east-1.elb.amazonaws.com`
this is: 10.0.1.212

2 and 1 denote different availibility zones
112 and 212 denote different (instances) machines.

`host my-elb.us-east-1.elb.amazonaws.com`
my-elb.us-east-1.elb.amazonaws.com has address 52.209.88.145
my-elb.us-east-1.elb.amazonaws.com has address 54.154.115.58

- we have two different public address in two different availibility zones

`terraform destroy`
