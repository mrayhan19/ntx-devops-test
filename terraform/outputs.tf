output "artifact_repo_url" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "load_balancer_ip" {
  value = kubernetes_service.app_svc.status[0].load_balancer[0].ip
}