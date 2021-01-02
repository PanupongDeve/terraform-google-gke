provider "google" {
  credentials = file("./credentials.json")

  project = var.google_project_id
  region  = var.region
  zone    = var.zone
}