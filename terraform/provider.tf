provider "google" {
  credentials = file("../gcloud-credentials.json")
  project     = "swift-doodad-413915"
  region      = "us_central1"
}