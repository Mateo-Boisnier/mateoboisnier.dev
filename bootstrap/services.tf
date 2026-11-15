resource "google_project_service" "iam_apis" {
  for_each           = toset(["iam.googleapis.com", "iamcredentials.googleapis.com"])
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

