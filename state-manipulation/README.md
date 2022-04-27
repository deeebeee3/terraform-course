`terraform state`

- will show you all the commands you can use...

`terraform state list`

`terraform state pull`

- shows complete state

`terraform state list`

`terraform state show [param]`
`terraform state show aws_ssm_parameter.myparameter`

- very handy command to show params in state file

`terraform state mv 'aws_ssm_parameter.myparameter' 'aws_ssm_parameter.myparameter2' `

- change move old name to the new name

`terraform list`

- can see new param name updated using mv

`terraform apply`

---

`terraform state rm aws_ssm_parameter.myparameter2`

- can remove a resource like this from local state

now if do terraform apply will get error...

To fix error we can update our local state file with the parameter from remote

`terraform import aws_ssm_parameter.myparameter2 /myapp/myparameter`

`terraform list`

`terraform destroy`
