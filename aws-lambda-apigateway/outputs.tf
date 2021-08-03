output "lambda_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.lambda_bucket.id
}

output "function_name" {
  description = "Name of the lambda function"
  value       = aws_lambda_function.hello_world.function_name
}

output "base_url" {
  description = "Base URL for API Gateway stage"
  value       = aws_apigatewayv2_stage.lambda.invoke_url
}