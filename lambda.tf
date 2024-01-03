
data "archive_file" "hellow_world_lambda_zip" {
  type        = "zip"
  source_file = "files/index.js"
  output_path = "hello_world.zip"
}

resource "aws_lambda_function" "hello_world" {
  filename         = "hello_world.zip"
  function_name    = "hello-world"
  role             = aws_iam_role.basic_lambda_access.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.hellow_world_lambda_zip.output_base64sha256
  runtime          = "nodejs14.x"
}
