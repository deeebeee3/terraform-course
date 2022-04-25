Create the public and private keys...

After apply log into the instance using the outputted instance
public IP address.

connect to instance

`ssh -i mykey ubuntu@52.208.XX.XX`

Install Mysql Client

`sudo apt-get install mysql-client`

`mysql -u root -h mariadb.wuhifuhwi.eu-west-1.rds.amazonaws.com -p 'myrandompassword`

\*Note the instance public IP and mariadb endpoint were outputted in console (output.tf).

Once logged into db can check all ok

`mysql> show databases;`

`mysql> \q` - to quit

---

`mariadb.wuhifuhwi.eu-west-1.rds.amazonaws.com` resolves to an internal private IP address - so you cannot access db from the internet.

We can check this using the linux `host` command.

For example:

`host mariadb.wuhifuhwi.eu-west-1.rds.amazonaws.com`

Will output for example:

mariadb.wuhifuhwi.eu-west-1.rds.amazonaws.com has address 10.0.4.135

10.0.4.135 - will be an internal private IP address.

`~$ logout`

`terraform destroy`

## Important:

"db.t2.small" small is a paid for RDS instance

change to

"db.t2.micro" if you want free instance
