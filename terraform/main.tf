resource "google_storage_bucket" "default" {
  name          = "tf-state-bucket-desafio-devops"
  force_destroy = false
  location      = "us-central1"
  storage_class = "STANDARD"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "api-comentarios"
  location = "us-central1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      ports {
        container_port = 8000
      }
      image = "us-central1-docker.pkg.dev/swift-doodad-413915/images/api:test-terraform2"
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }  
  }
}

resource "google_cloud_run_v2_service" "grafana" {
  name     = "grafana-service"
  location = "us-central1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      ports {
        container_port = 3000
      }
      image    = "grafana/grafana:latest"
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
}
