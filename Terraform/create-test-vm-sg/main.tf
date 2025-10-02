## create an EC2 instance for the app

# provide cloud provider name
provider "aws" {
    # where to create - which region
    region = var.instance_region
}

data "aws_vpc" "default" {
  default = true
}

## specify resource to create database EC2 instance
resource "aws_instance" "db_instance" {

  # use db ami-id (for ubuntu 22.04 lts)
  ami = var.db_ami_id

  # which type of instance
  instance_type = var.instance_type
  
  # Attach the key to be used with EC2 instance
  key_name = var.key_name
  
  # db subnet id
  #subnet_id = var.db_subnet_id   NOT NEEDED YET

  # reference the database security group
  vpc_security_group_ids = [aws_security_group.database_sg.id]

  # name the instance
  tags = {
      Name = var.db_instance_name
  }
}

## specify resource to create database security group
resource "aws_security_group" "database_sg" {

  # make sure you already have a VPC resource
  vpc_id = data.aws_vpc.default.id
  name = var.db_sg_name

  # Allow SSH
  ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${data.external.my_ip.result.ip}/32"] 
  }

  # allow MongoDB from app security
  ingress {
      from_port       = 27017
      to_port         = 27017
      protocol        = "tcp"
      security_groups = [aws_security_group.app_sg.id]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = var.db_sg_name
  }
  
}

## specify resource to create app instance
resource "aws_instance" "app_instance" {
 
  # use app ami-id (for ubuntu 22.04 lts)
  ami = var.app_ami_id
  
  # which type of instance
  instance_type = var.instance_type

  # Attach the key to be used with EC2 instance
  key_name = var.key_name

  # add a public ip to this instance
  associate_public_ip_address = var.associate_public_ip_address

  # add user data
  user_data = templatefile("${path.module}/user-data.sh", {
    DB_HOST = aws_instance.db_instance.private_ip
  }) 

  # app subnet id
  # subnet_id = var.app_subnet_id       NOT NEEDED YET!!

  # name the instance
  tags = {
      Name = var.app_instance_name
  }

  # reference the app security group
  vpc_security_group_ids = [aws_security_group.app_sg.id]
}

## store the current local IP address
data "external" "my_ip" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

## Create an AWS security group for the app
resource "aws_security_group" "app_sg" {
  name = var.app_sg_name
  description = "Allows SSH, HTTP, and port 3000"

  # make sure you already have a VPC resource
  vpc_id = data.aws_vpc.default.id

  # Allow SSH from my local machine
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # replaced with my current IP 
    cidr_blocks = ["${data.external.my_ip.result.ip}/32"] 
  }

  # Allow HTTP from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow port 3000 from anywhere
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.app_sg_name
  }
}