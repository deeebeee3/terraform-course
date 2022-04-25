# HERE WE ARE JUST CREATING THE S3 BUCKET - its just another resource
resource "aws_s3_bucket" "b" {
  bucket = "mybucket-c29df1"

  tags = {
    Name = "mybucket-c29df1"
  }
}

