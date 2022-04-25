# Autoscaling

`ssh-keygen -f mykey`

`terraform apply`

In aws console we will be able to see ec2 instance and public
IP if we didnt choose to output it.

Click on auto scaling groups in the left sidebar.

There will will see our autoscaling we have created

If we click on scaling policies - we will see the 2 policies we created - scleup and scale down...

---

Then if we go to Cloudwatch in AWS

we will be able to see the cloudwatch metrics

We will be able to see the 2 alarms we created in the Alarm Summary.

We can click on one of the alarms (i.e. SCALE-UP) to see more information....

---

For example We can test our SCALE-UP alarm by generating some load...
then we should see the load spike and we should see our second instance being spun up.

So we can go to instances get the public ip address - login to the initial FIRST instance and generate some load...

`ssh -i mykey ubuntu@xx.xxx.xxx.xxx`

We can install this tool to generate some load
`sudo apt-get install stress`

Then i'm going to stress the cpu for 300 seconds (5 MINUTES)
`stress --cpu --timeout 300`

Then if we go back to the console and keep refreshing - we should see the second ec2 instance spin up.

If we click on the monitoring tab - we should see a higher cpu utilization... that should trigger the scale-up alarm....

`CPUUtilization >= 30 for 4 minutes`

---

Then after our stress test is finished after 5 minutes - we should
see the SCALE-DOWN alarm trigger (`CPUUtilization <= 5 for 4 minutes`). And one of the instances will be removed again.

Which instance will be removed depends on the policy - we havent specified any policy which means default - so it will just use the AWS algorithm to decide which instance to remove...

# DON'T FORGET TO

`terraform destroy`
