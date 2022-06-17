# Terraform Google CMS

This repository provides a suite of Terraform modules for deploying Strapi on
Google Cloud.

The whole repository is intended to be cloned as a single unit, then forked into
separate repositories to initiate production use, or used as is and periodically
updated as a complete toolkit for prototyping.

## Modules

The suite of modules in this repository is designed for rapid deployment of the
standard Strapi stack, and to be reasonably simple and readable so that they can
be forked and modified when the use of third-party code and sources is not
allowed.

Currently module architecture:

- **database**: SQL database.
- **delivery**: Continuous delivery pipeline.
- **deploy**: Continuous build and deploy pipeline.
- **cms**: Strapi CMS service.
- **front**: Consumer-facing application service.
- **edge**: Public facing edge network.
- **project**: Global common resources.

## Contribution

If you are interested in contributing to this repository, the best way to do so
is to either fork it and then make your own changes or create a new branch.
To enter the development mode, you can use the [direnv](https://direnv.net/)
utility which need at least [Nix 2.4](https://nixos.org/nix/download.html).

Nix and direnv are the best way to reproduce the development environment, but
you can also use your own environment management tool or install the
dependencies yourself:

- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [pre-commit](https://pre-commit.com/)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

## Examples

The `environments` directory contain a complete example of deployment.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->