#task2sns_sqs_subscription.tf
resource "aws_sns_topic_subscription" "sns_to_sqs" {
  provider  = aws.account_b
  topic_arn = "arn:aws:sns:us-east-1:account_a_account_id:sns-topic"  # YET TO BE REPLACED WITH ACTUAL ARN
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_queue.arn
}