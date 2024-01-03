data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_dashboard" "lambda_logs_metric_filter" {
  dashboard_name = "lambda-logs-metrics"
  dashboard_body = templatefile("${path.module}/files/dashboards.json", {})
}

resource "aws_cloudwatch_metric_alarm" "monitor_lambda_cold_start" {
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.cloudwatch_send_alarms.arn]
  alarm_description   = "Monitor Lambda Startup duration"
  datapoints_to_alarm = 3
  alarm_name          = "monitor-lambda-cold-start"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "InitDuration"
  namespace           = "LambdaLogsMetricFilter"
  period              = "60"
  statistic           = "Average"
  threshold           = "250"
  treat_missing_data  = "missing"
}
