output "artifact_repo_url" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}