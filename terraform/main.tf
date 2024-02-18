resource "google_storage_bucket" "default" {
  name          = "tf-state-bucket-desafio-devops"
  force_destroy = false
  location      = "us-central1"
  storage_class = "STANDARD"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "api-comentarios"
  location = "us-central1"
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/swift-doodad-413915/images/api:${var.commit_hash}"
    }
  }
}
