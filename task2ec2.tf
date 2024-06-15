# task2ec2.tf
resource "aws_instance" "server_a" {
  provider = aws.account_a
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "glidertest.pem"
  user_data     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y python3
                pip3 install boto3
                # Add script to publish to SNS
                cat <<EOT >> /home/ec2-user/publish_sns.py
                import boto3
                from datetime import datetime

                sns = boto3.client('sns', region_name='us-east-1')

                message = f"Hello from server A at {datetime.utcnow().strftime('%Y-%m-%d-%H:%M:%S')}"
                response = sns.publish(
                    TopicArn='${aws_sns_topic.sns_topic.arn}',
                    Message=message
                )
                print("Message published: ", response)
                EOT
                chmod +x /home/ec2-user/publish_sns.py
                EOF
  tags = {
    Name = "Server_A"
  }
}

provider "aws" {
  alias  = "account_b"
  region = "us-east-1"
  profile = "account_b"
}