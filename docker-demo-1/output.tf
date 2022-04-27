output "myapp-repository-URL" {
  value = aws_ecr_repository.myapp.repository_url
}

# Output the registry URL after it was created. Which we can use 
# to push our image to the registry.