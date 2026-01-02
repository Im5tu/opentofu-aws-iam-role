# OpenTofu AWS IAM Role

OpenTofu module for creating and managing AWS IAM roles with inline policies and managed policy attachments.

## Usage

```hcl
module "lambda_role" {
  source = "git::https://github.com/im5tu/opentofu-aws-iam-role.git?ref=main"

  name                 = "my-lambda-role"
  assume_role_services = ["lambda.amazonaws.com"]

  policies = {
    "s3-access" = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = ["arn:aws:s3:::my-bucket/*"]
      }]
    })
  }

  external_attachment_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

  tags = {
    Environment = "production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.9 |
| aws | ~> 6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the role | `string` | `null` | no |
| name_prefix | The name prefix of the role | `string` | `null` | no |
| path | The path the role is stored in | `string` | `""` | no |
| description | The description of the role | `string` | `null` | no |
| max_session_duration | Maximum session duration (in seconds) for the role | `number` | `null` | no |
| permission_boundary | The permission boundary to apply to the role | `string` | `null` | no |
| assume_role_services | List of AWS Services that can assume the role | `list(string)` | `[]` | no |
| assume_role_arns | List of Account IDs/ARNs that can assume the role | `list(string)` | `[]` | no |
| assume_role_custom | Custom assume role policy JSON. Overrides assume_role_services and assume_role_arns | `string` | `null` | no |
| external_attachment_arns | List of pre-existing IAM Policy ARNs to attach | `list(string)` | `[]` | no |
| policies | Map of policy names to policy JSON strings | `map(string)` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the IAM role |
| name | The name of the IAM role |
| id | The unique ID of the IAM role |

## Development

### Validation

This module uses GitHub Actions for validation:

- **Format check**: `tofu fmt -check -recursive`
- **Validation**: `tofu validate`
- **Security scanning**: Checkov, Trivy

### Local Development

```bash
# Format code
tofu fmt -recursive

# Validate
tofu init -backend=false
tofu validate
```

## License

MIT License - see [LICENSE](LICENSE) for details.
