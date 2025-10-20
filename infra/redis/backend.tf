terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "bucket-daytrader-dev-data"
    prefix = "terraform/state/redis"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}
