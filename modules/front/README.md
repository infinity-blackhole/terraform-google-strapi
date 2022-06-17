<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.default_all_user_run_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_project_service.run](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | The name of the client | `string` | `"gcloud"` | no |
| <a name="input_client_version"></a> [client\_version](#input\_client\_version) | The version of the client | `string` | `"381.0.0"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The amount of CPU to allocate to the container | `string` | `"1000m"` | no |
| <a name="input_graphql_url"></a> [graphql\_url](#input\_graphql\_url) | The GraphQL URL | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The Docker image to use | `string` | `"gcr.io/cloudrun/placeholder"` | no |
| <a name="input_max_instances"></a> [max\_instances](#input\_max\_instances) | The maximum number of instances to run | `number` | `1` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to allocate to the container | `string` | `"256Mi"` | no |
| <a name="input_name"></a> [name](#input\_name) | The full name of the service | `string` | `"strapi-front"` | no |
| <a name="input_project"></a> [project](#input\_project) | The Google Cloud project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Google Cloud region | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The service account to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service"></a> [service](#output\_service) | The Cloud Run service |
<!-- END_TF_DOCS -->