# main.tf

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Install Apache
              yum update -y
              yum install -y httpd
              # Start Apache
              systemctl start httpd
              systemctl enable httpd
              # Create a simple HTML file
              echo "<html><body><h1>Hello World from Apache Web Server!</h1></body></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform_Web_Server"
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

