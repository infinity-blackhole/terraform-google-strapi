<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.21 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.21 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [random_id.default_cloudsql](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_availability_type"></a> [database\_availability\_type](#input\_database\_availability\_type) | The availability type of the Cloud SQL instance | `string` | `"ZONAL"` | no |
| <a name="input_database_backup_retention_days"></a> [database\_backup\_retention\_days](#input\_database\_backup\_retention\_days) | The number of days to retain the backup | `number` | `180` | no |
| <a name="input_database_backup_start_time"></a> [database\_backup\_start\_time](#input\_database\_backup\_start\_time) | The time of day to start the backup | `string` | `"01:00"` | no |
| <a name="input_database_disk_type"></a> [database\_disk\_type](#input\_database\_disk\_type) | The type of disk to use | `string` | `"PD_SSD"` | no |
| <a name="input_database_tier"></a> [database\_tier](#input\_database\_tier) | The tier of the Cloud SQL instance | `string` | `"db-f1-micro"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The version of the Cloud SQL instance | `string` | `"POSTGRES_14"` | no |
| <a name="input_name"></a> [name](#input\_name) | The full name of the service | `string` | `"strapi"` | no |
| <a name="input_network"></a> [network](#input\_network) | The name of the network | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The Google Cloud project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Google Cloud region | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The Google Cloud zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | The SQL database instance |
<!-- END_TF_DOCS -->