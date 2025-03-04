terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket1214"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}