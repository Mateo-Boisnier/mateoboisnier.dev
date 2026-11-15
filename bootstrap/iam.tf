# Identité que Terraform utilisera par impersonation (OPTIMIZATIONS.md #15).

resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "Terraform service account"
  description  = "This service account receives rights to modify the infrastructure and can be impersonated when managing infrastructure with terraform."

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [google_project_service.iam_apis]
}

resource "google_service_account_iam_member" "right_admin_impersonate_sa_terraform" {
  service_account_id = google_service_account.terraform.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.admin_email}"
}

resource "google_storage_bucket_iam_member" "right_sa_terraform_on_state_bucket" {
  bucket = google_storage_bucket.backend_bucket_terraform.name
  role   = "roles/storage.objectUser"
  member = google_service_account.terraform.member
}
