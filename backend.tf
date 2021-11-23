#BACKEND configuration

terraform {
  backend "s3" {
    bucket = "talent-academy-834539731159-tfstates"
    key    = "sprint2/week1/basic-vpc/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}

