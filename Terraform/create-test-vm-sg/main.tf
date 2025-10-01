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

  # name the instance
  tags = {
      Name = var.instance_name
  }

  

  # create the security group
  #vpc_security_group_ids = [aws_security_group.security_group_name.id]
}

# Create an AWS security group 
