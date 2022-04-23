ipconfig getifaddr en0 (private IP wifi)

ipconfig getifaddr en0 (private IP wired ethernet)

curl ifconfig.me (public IP from router to outside world)

---

`terraform init`

`terraform apply`

---

ssh 18.203.89.170 -l ubuntu -i mykey

---

`sudo -s`

will run the shell as root user

ubuntu@ip-10-0-1-122:~$ sudo -s
root@ip-10-0-1-122:~#

---

`df -h` (diskfree) (-h flag means human readable)

command shows display amount of disk space available on filesystem

```
root@ip-10-0-1-122:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            488M     0  488M   0% /dev
tmpfs           100M  3.3M   96M   4% /run

/dev/xvda1      7.7G  1.1G  6.7G  14% /

tmpfs           496M     0  496M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           496M     0  496M   0% /sys/fs/cgroup
/dev/loop0       33M   33M     0 100% /snap/snapd/13170
/dev/loop1       56M   56M     0 100% /snap/core18/2128
/dev/loop2       25M   25M     0 100% /snap/amazon-ssm-agent/4046
tmpfs           100M     0  100M   0% /run/user/1000
root@ip-10-0-1-122:~#
```

---

Here we see the 8GB EBS storage automatically added by the AMI that comes with t2 instance... This storage is set to be automatically removed when the instance is TERMINATED, unless we specify it not to.

`/dev/xvda1 7.7G 1.1G 6.7G 14% /`

---

Some instances other than t2 have local ephemeral storage - this type of storage will always be lost when the instance TERMINATES.

---

The `resource "aws_ebs_volume" "ebs-volume-1"` we created we can't see yet becuase we have to create a filesystem on it and then mount it. With this volume, if the instance gets removed the volume will still persist...

---

So now we need to create a filesystem on the ssd device we created
in the instance: "/dev/xvdh"

`mkfs.ext4 /dev/xvdh` - make filesystem on device "/dev/xvdh"

ext4 means a linux filesystem...

---

Now lets mount the disk

`mkdir /data`
`mount /dev/xvdh /data` - mount the disk into the /data directory.

---

`df -h`

now we will see the mounted disk

```
root@ip-10-0-1-122:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            488M     0  488M   0% /dev
tmpfs           100M  3.3M   96M   4% /run
/dev/xvda1      7.7G  1.0G  6.7G  14% /
tmpfs           496M     0  496M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           496M     0  496M   0% /sys/fs/cgroup
/dev/loop0       33M   33M     0 100% /snap/snapd/13170
/dev/loop1       56M   56M     0 100% /snap/core18/2128
/dev/loop2       25M   25M     0 100% /snap/amazon-ssm-agent/4046
tmpfs           100M     0  100M   0% /run/user/1000

/dev/xvdh        20G   44M   19G   1% /data

root@ip-10-0-1-122:~#
```

---

HOWEVER IF YOU REBOOT THE INSTANCE THE VOLUME WON"T BE AUTOMATICALLY
REMOUNTED...

To fix this we want to put the volume in /etc/fstab...

`vim /etc/fstab`

and add the line at the end:

`/dev/xvdh /data ext4 defaults 0 0`

and save the file.

---

To know what 0 0 means do `man fstab`

- its the fifth and the sixth field...

---

So now we can just

`unmount /data`
`mount /data`

without specifying device name as we saved it in fstab and it can just look it up in fstab...

SO NOW IF WE REBOOT THE INSTANCE WE WILL ALWAYS HAVE `/data` AVAILABLE.

---

HOWEVER IF THE INSTANCE IS TERMINATED AND WE RELAUNCH ONE,
THE CHANGE WILL BE GONE, becuase /etc/fstab is based on /etc
and / will be gone...

---

WE CAN FIX PREVENT THIS BY USING USERDATA - it will allow
us to execute scripts on instance launch - for example a script could be to add a new line in the /etc/fstab file to make sure we can mount data:

`/dev/xvdh /data ext4 defaults 0 0`

like we did above...

---

We can snapshot our EBS volumes

If our whole infrasucture goes down we can bring it back up...

---

BUGFIX WHEN DESTROY NOT HAPPEN CLEANLY:

I had the same problem. `terraform destroy` fails for the reason shown above. Then the terraform.tfstate file gets corrupted so I copy from the backup and run `terraform refresh`. Then I made the `stop_instance_before_detaching=true` changes to instance.tf, run `terraform refresh` and then re-ran `terraform destroy`.
