terraform {
    backend "gcs" { 
      bucket  = "ntx-terraform-state"
      prefix  = "feature"
    }
}

provider "google" {
  project = var.project
  region = var.region
}