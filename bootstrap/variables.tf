variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "admin_email" {
  description = "This email is authorized to impersonate the Terraform SA"
  type        = string
  sensitive   = true
}
