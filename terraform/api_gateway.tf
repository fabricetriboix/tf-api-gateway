resource "aws_api_gateway_rest_api" "this" {
  name = var.api_name
}

resource "aws_api_gateway_resource" "widget" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id = aws_api_gateway_rest_api.this.root_resource_id
  path_part = "widget"
}

resource "aws_api_gateway_method" "get_widget" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.widget.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_widget" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.widget.id
  http_method = aws_api_gateway_method.get_widget.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.this.invoke_arn
}

data "aws_caller_identity" "this" {
}

resource "aws_lambda_permission" "api_invoke_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal = "apigateway.amazonaws.com"

  // More info on the source ARN here:
  // https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:eu-west-1:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.get_widget.http_method}${aws_api_gateway_resource.widget.path}"
}

// XXX resource "aws_api_gateway_method_response" "get_widget" {
// XXX   rest_api_id = aws_api_gateway_rest_api.this.id
// XXX   resource_id = aws_api_gateway_resource.widget.id
// XXX   http_method = aws_api_gateway_method.get_widget.http_method
// XXX   status_code = "500"
// XXX }
