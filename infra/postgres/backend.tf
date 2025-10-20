terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "bucket-daytrader-dev-data"
    prefix = "cloudsql"
  }
}
