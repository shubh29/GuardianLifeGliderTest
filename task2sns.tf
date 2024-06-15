# task2sns.tf
resource "aws_sns_topic" "sns_topic" {
  provider = aws.account_a
  name     = "sns-topic"
}
