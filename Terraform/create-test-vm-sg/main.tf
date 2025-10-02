# create an EC2 instance

# provide cloud provider name
provider "aws" {
    # where to create - which region
    region = var.instance_region
}


# specify resource to create EC2 instance
resource "aws_instance" "test_instance" {
 
  # use app ami-id (for ubuntu 22.04 lts)
  ami = var.app_ami_id
  
  # which type of instance
  instance_type = var.instance_type

  # Attach the key to be used with EC2 instance
  key_name = var.key_name

  # add a public ip to this instance
  associate_public_ip_address = var.associate_public_ip_address

  # user data
  user_data = local.user_data_script

  # app subnet id
  subnet_id = var.app_subnet_id

  # name the instance
  tags = {
      Name = var.app_instance_name
  }

  # reference the security group
  vpc_security_group_ids = [aws_security_group.app_sg.id]
}

# store the current IP address
data "external" "my_ip" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

# Create an AWS security group for the app
resource "aws_security_group" "app_sg" {
  name = var.app_sg_name
  description = "Allows SSH, HTTP, and port 3000"

  # make sure you already have a VPC resource
  vpc_id = var.my_vpc_id

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
