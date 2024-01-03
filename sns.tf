resource "aws_sns_topic" "cloudwatch_send_alarms" {
  name = "cloudwatch-send-alarms"
  policy = templatefile("${path.module}/files/sns.json", {
    account_id = data.aws_caller_identity.current.account_id
    alarm_name = "cloudwatch-send-alarms"
  })
}

resource "aws_sns_topic_subscription" "cloudwatch_send_alarms_emails" {
  for_each  = toset(local.email_list)
  topic_arn = aws_sns_topic.cloudwatch_send_alarms.arn
  protocol  = "email"
  endpoint  = each.value
}
