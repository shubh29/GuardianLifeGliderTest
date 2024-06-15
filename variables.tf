# variables.tf

variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  description = "AMI ID with autobahn"
  default     = "ami-0ade9dd2607d3c5d7"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "glidertest"
}

