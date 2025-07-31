# Tofu Guidelines

The following OpenTofu configuration guidelines must be followed for a pack to be distributed by Apstra Hub:
- All OpenTofu configuration files are placed in the `pack/tofu/` directory.
- All OpenTofu configuration file names must end with `.tf`.
- Only OpenTofu configuration files may be placed in the `pack/tofu/` directory.
- All OpenTofu configuration files must be formatted with `tofu fmt`.
- A `terraform` block containing only the following must be included in one of the `.tf` files:
  ```terraform
  terraform {
    required_providers {
      apstra = {
        source = "Juniper/apstra" # relative path is required
        version = "~> 0.92.2"     # the bugfix release must use the "~>" operator
      }
    }
  }
  ```
- Only the `Juniper/apstra` provider may be used.
- The `Juniper/Apstra` provider must use the local name `apstra`.
- No `provider` blocks are permitted.
- No `provisioner` blocks are permitted within `resource` blocks.
- Tofu functions which reference the local filesystem are not permitted.
- Version constraints
  - Provider versions earlier than `0.86.0` are not supported.
  - The version must use the `~>` operator.
    - specify version `0.x.x` releases as `~> major.minor.bugfix`  e.g. `~> 0.92.2`
    - specify version `1.x` and later releases as `~> major.minor` e.g. `~> 1.1`
  - As July 30 2025, provider versions through `0.92.2` are available.
