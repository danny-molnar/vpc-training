# AWS provider
# If we have multiple providers, we have to add an alias in the provider block

provider "aws" {
  # alias goes here in case of multiple providers
  # alias = "euw1"
  region = "eu-west-1"
}