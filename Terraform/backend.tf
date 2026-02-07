
terraform {
  backend "s3" {
    bucket         = "insta-tf-state-bkt"
    key            = "vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true

  }
}
