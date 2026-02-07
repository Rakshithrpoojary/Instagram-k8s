provider "aws" {
  region     = var.aws-cred.region
  access_key = var.aws-cred.access-key
  secret_key = var.aws-cred.secret-key

}
