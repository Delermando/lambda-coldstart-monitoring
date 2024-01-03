resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_metric_filter" "init_duration" {
  name           = "InitDuration"
  pattern        = "[report_label=\"REPORT\", ...,init_duration1=\"Init\", init_duration2=\"Duration:\", init_duration_value, init_duration_unit=\"ms\"]"
  log_group_name = aws_cloudwatch_log_group.hello_world.name

  metric_transformation {
    name      = "InitDuration"
    namespace = "LambdaLogsMetricFilter"
    unit      = "Milliseconds"
    value     = "$init_duration_value"
  }
}