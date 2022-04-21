terraform {
    backend "s3" {
        bucket = "terraform-tfstate-287hfh23f"
        key    = "terraform/demo4"
    }
}