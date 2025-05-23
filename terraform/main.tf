terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repo_name
  description   = "Docker repository for app"
  format        = "DOCKER"
}

resource "google_container_cluster" "autopilot_cluster" {
  name               = "autopilot-cluster"
  location           = var.region
  enable_autopilot   = true
}

output "artifact_registry_url" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}"
}

output "gke_cluster_name" {
  value = google_container_cluster.autopilot_cluster.name
}
