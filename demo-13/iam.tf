# group definition

# Create the AWS IAM group (this group doesn't have access to anything yet)
resource "aws_iam_group" "administrators" {
  name = "administrators"
}

#Attach the AWS managed Administrator policy to the group
# (These poilicies are already created by AWS)
resource "aws_iam_policy_attachment" "administrators-attach" {
  name       = "administrators-attach"
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create the users
resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

# Add the users to the group
resource "aws_iam_group_membership" "administrators-users" {
  name = "administrators-users"
  users = [
    aws_iam_user.admin1.name,
    aws_iam_user.admin2.name,
  ]
  group = aws_iam_group.administrators.name
}

output "warning" {
  value = "WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources"
}

# Assign passwords to the users from the AWS console or the AWS CLI.
# We don't do if from here otherwise passwords would be in state file - not secure.

