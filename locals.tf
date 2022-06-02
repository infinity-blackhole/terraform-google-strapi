locals {
  stripe_cloud_sql_username = "${google_service_account.strapi.account_id}@${var.project}.iam"
}
