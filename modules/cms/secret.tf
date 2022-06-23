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
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "google_secret_manager_secret_version" "default_cloudsql_password" {
  secret      = google_secret_manager_secret.default_cloudsql_password.id
  secret_data = google_sql_user.default.password
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "google_secret_manager_secret" "admin_jwt_secret" {
  project   = var.project
  secret_id = "${var.name}-admin-jwt-secret"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "random_string" "admin_jwt_secret" {
  length  = 32
  special = false
}

resource "google_secret_manager_secret_version" "admin_jwt_secret" {
  secret      = google_secret_manager_secret.admin_jwt_secret.id
  secret_data = random_string.admin_jwt_secret.result
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "google_secret_manager_secret" "api_token_salt" {
  project   = var.project
  secret_id = "${var.name}-api-token-salt"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "random_string" "api_token_salt" {
  length  = 32
  special = false
}

resource "google_secret_manager_secret_version" "api_token_salt" {
  secret      = google_secret_manager_secret.api_token_salt.id
  secret_data = random_string.api_token_salt.result
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "google_secret_manager_secret" "app_keys" {
  project   = var.project
  secret_id = "${var.name}-app-keys"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "random_string" "app_keys" {
  length  = 32
  special = false
}

resource "google_secret_manager_secret_version" "app_keys" {
  secret      = google_secret_manager_secret.app_keys.id
  secret_data = random_string.app_keys.result
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "google_secret_manager_secret" "jwt_secret" {
  project   = var.project
  secret_id = "${var.name}-jwt-secret"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  depends_on = [
    google_project_service.secret_manager
  ]
}

resource "random_string" "jwt_secret" {
  length  = 32
  special = false
}

resource "google_secret_manager_secret_version" "jwt_secret" {
  secret      = google_secret_manager_secret.jwt_secret.id
  secret_data = random_string.jwt_secret.result
  depends_on = [
    google_project_service.secret_manager
  ]
}
