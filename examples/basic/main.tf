module "lambda_role" {
  source = "../.."

  name                 = "example-lambda-role"
  assume_role_services = ["lambda.amazonaws.com"]

  external_attachment_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

  tags = {
    Environment = "example"
  }
}

output "role_arn" {
  value = module.lambda_role.arn
}

output "role_name" {
  value = module.lambda_role.name
}
