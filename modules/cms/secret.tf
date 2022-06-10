resource "google_secret_manager_secret" "default_cloudsql_password" {
  project   = var.project
  secret_id = "${var.name}-cloudsql-password"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "default_cloudsql_password_version" {
  secret      = google_secret_manager_secret.default_cloudsql_password.id
  secret_data = google_sql_user.default.password
}

resource "google_secret_manager_secret" "admin_jwt_secret" {
  project   = var.project
  secret_id = "admin-jwt-secret"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret" "api_token_salt" {
  project   = var.project
  secret_id = "api-token-salt"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret" "app_keys" {
  project   = var.project
  secret_id = "app-keys"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret" "jwt_secret" {
  project   = var.project
  secret_id = "jwt-secret"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}
