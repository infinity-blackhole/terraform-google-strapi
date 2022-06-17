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
| [google_cloudbuild_trigger.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_project_service.cloudbuild](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the service | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The full name of the service | `string` | `"strapi"` | no |
| <a name="input_percentage"></a> [percentage](#input\_percentage) | The percentage of traffic to use for the release | `number` | `100` | no |
| <a name="input_project"></a> [project](#input\_project) | The Google Cloud project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Google Cloud region | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository to use for the service | `string` | n/a | yes |
| <a name="input_tag"></a> [tag](#input\_tag) | The tag to use for the release | `string` | `"^v([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:\\+[0-9A-Za-z-]+)?$"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->