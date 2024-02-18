terraform {
 backend "gcs" {
   bucket  = "tf-state-bucket-desafio-devops"
   prefix  = "terraform/state"
 }
}