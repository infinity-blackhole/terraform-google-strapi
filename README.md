# Terraform Google Strapi

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

- **base**: Essential services and infrastructure.
- **cms**: Deploys a Strapi CMS.
- **app**: Deploys a consumer-facing application.
- **edge**: Deploys a Strapi CMS with a public facing edge.

## Examples

The `environments` directory contain a complete example of deployment.
