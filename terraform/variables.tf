variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region (e.g. us-central1)"
  type        = string
  default     = "asia-southeast2"
}

variable "repo_name" {
  description = "Name of the Artifact Registry Docker repo"
  type        = string
  default     = "app-repo"
}
