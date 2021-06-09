# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  -------------------------------------
#   AKKA SERVERLESS GENESIS ENVIRONMENT
#  -------------------------------------
#
#  This environment contains the resources implementing the atlantis service,
#  a github-driven webhook that generates a plan when a pull request is made,
#  displays the plan in the comments and allows any reviewer to apply and
#  merge it, keeping the state in sync with version control.
#

terraform {
  required_version = "~> 0.15.0"
  # https://www.terraform.io/docs/backends/types/gcs.html
}

# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = "vital-fish"
}

# https://www.terraform.io/docs/providers/google/index.html
provider "google-beta" {
  project = "vital-fish"
}

# https://www.terraform.io/docs/providers/google/r/google_project_service.html
resource "google_project_service" "services" {
  for_each = toset([
    "run.googleapis.com",
    "dns.googleapis.com",
    "secretmanager.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

