# task2sqs.tf
resource "aws_sqs_queue" "sqs_queue" {
  provider = aws.account_b
  name = "sqs-queue"
}