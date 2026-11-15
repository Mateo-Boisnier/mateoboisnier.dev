# Bootstrap : ressources créées AVANT le backend distant (state local ici).

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.1"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "backend_bucket_terraform" {
  name                        = "1301200515-backend-terraform"
  location                    = var.region
  public_access_prevention    = "enforced"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  lifecycle_rule {
    condition {
      num_newer_versions = 25
    }
    action {
      type = "Delete"
    }
  }
}
