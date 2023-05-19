resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my_api"
  description = "My API service"
}

resource "aws_api_gateway_resource" "resource_process" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "process-products"
}

resource "aws_api_gateway_method" "method_process" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.resource_process.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_process" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_process.id
  http_method = aws_api_gateway_method.method_process.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_products.invoke_arn
}

resource "aws_lambda_permission" "permission_process" {
  statement_id  = "AllowExecutionFromAPIGatewayProcess"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_products.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/POST/process-products"
}

resource "aws_api_gateway_resource" "resource_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "get-products"
}

resource "aws_api_gateway_method" "method_get" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.resource_get.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_get.id
  http_method = aws_api_gateway_method.method_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_products.invoke_arn
}

resource "aws_lambda_permission" "permission_get" {
  statement_id  = "AllowExecutionFromAPIGatewayGet"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_products.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/GET/get-products"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.integration_process,
    aws_api_gateway_integration.integration_get
  ]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
}

resource "aws_api_gateway_method" "options_method_get_products" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.resource_get.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_response_get_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_get.id
  http_method = aws_api_gateway_method.options_method_get_products.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}

resource "aws_api_gateway_integration" "options_integration_get_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_get.id
  http_method = aws_api_gateway_method.options_method_get_products.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_integration_response" "options_integration_response_get_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_get.id
  http_method = aws_api_gateway_method.options_method_get_products.http_method
  status_code = aws_api_gateway_method_response.options_response_get_products.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
  }
}

resource "aws_api_gateway_method" "options_method_process_products" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.resource_process.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_response_process_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_process.id
  http_method = aws_api_gateway_method.options_method_process_products.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true,
  }
}

resource "aws_api_gateway_integration" "options_integration_process_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_process.id
  http_method = aws_api_gateway_method.options_method_process_products.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_integration_response" "options_integration_response_process_products" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.resource_process.id
  http_method = aws_api_gateway_method.options_method_process_products.http_method
  status_code = aws_api_gateway_method_response.options_response_process_products.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
  }
}
