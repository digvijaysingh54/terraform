data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "${var.source_path}"
  output_path = "${path.module}/lambda_function.zip"
}
resource "aws_lambda_function" "timestamp_lambda" {
  filename         = "${path.module}/lambda_function.zip"
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  runtime          = var.runtime
  handler          = "lambda_function.lambda_handler"
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.timestamp_lambda.function_name
  principal     = "apigateway.amazonaws.com"
 # source_arn    = var.api_deployment_arn
}

resource "aws_iam_role" "lambda_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.lambda_role.name
}
resource "aws_iam_role_policy_attachment" "lambda_policy1" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}
resource "aws_iam_role_policy_attachment" "lambda_policy2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
  role       = aws_iam_role.lambda_role.name
}
resource "aws_iam_role_policy_attachment" "lambda_policy3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
  role       = aws_iam_role.lambda_role.name
}