terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = "./keys/my-creds.json"
  project     = "emaily-dev-346007"
  region      = "us-central1"
}


resource "google_storage_bucket" "data-lake-bucket" {
  name          = "emaily-dev-346007-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "emaily_dataset"
  default_table_expiration_ms = 50976000
  project    = "emaily-dev-346007"
  location   = "US"
}