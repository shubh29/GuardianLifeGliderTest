# task2ec2_accountb.tf
resource "aws_instance" "server_b" {
  provider = aws.account_b
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "glidertestb.pem"
  user_data     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y python3
                pip3 install boto3
                # Add script to consume from SQS and upload to S3
                cat <<EOT >> /home/ec2-user/consume_sqs.py
                import boto3
                import time
                from datetime import datetime

                sqs = boto3.client('sqs', region_name='us-east-1')
                s3 = boto3.client('s3')
                queue_url = '${aws_sqs_queue.sqs_queue.url}'
                bucket_name = '${aws_s3_bucket.bucket.bucket}'

                while True:
                    response = sqs.receive_message(
                        QueueUrl=queue_url,
                        MaxNumberOfMessages=1,
                        WaitTimeSeconds=20,
                    )

                    messages = response.get('Messages', [])
                    for message in messages:
                        body = message['Body']
                        timestamp = datetime.utcnow().strftime('%Y-%m-%d-%H:%M:%S')
                        filename = f"{timestamp}-message.log"
                        with open(filename, 'w') as file:
                            file.write(body)

                        s3.upload_file(filename, bucket_name, filename)
                        sqs.delete_message(
                            QueueUrl=queue_url,
                            ReceiptHandle=message['ReceiptHandle']
                        )
                    time.sleep(10)
                EOT
                chmod +x /home/ec2-user/consume_sqs.py
                EOF
  tags = {
    Name = "Server_B"
  }
}