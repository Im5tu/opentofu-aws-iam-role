data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "AssumeRole"

    dynamic "principals" {
      for_each = [var.assume_role_services]
      iterator = p

      content {
        type        = "Service"
        identifiers = p.value
      }
    }

    dynamic "principals" {
      for_each = [var.assume_role_arns]
      iterator = p

      content {
        type        = "AWS"
        identifiers = p.value
      }

    }

    actions = ["sts:AssumeRole", "sts:TagSession"]
    effect  = "Allow"
  }
}

resource "aws_iam_role" "role" {
  name                 = var.name
  name_prefix          = var.name_prefix
  assume_role_policy   = var.assume_role_custom != null ? var.assume_role_custom : data.aws_iam_policy_document.assume_role.json
  path                 = length(var.path) > 0 ? "/${trim(var.path, "/")}/" : null
  description          = var.description
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permission_boundary
  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_iam_role_policy" "role_policies" {
  for_each = var.policies
  name     = each.key
  policy   = each.value
  role     = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each   = toset(var.external_attachment_arns)
  role       = aws_iam_role.role.name
  policy_arn = each.value
}
