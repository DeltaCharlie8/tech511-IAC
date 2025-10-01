# create an EC2 instance

# provide cloud provider name
provider "aws" {
    # where to create - which region
    region = var.instance_region
}


# specify resource to create EC2 instance
resource "aws_instance" "test_instance" {
 
    # which ami ID ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
    ami = var.app_ami_id
   
    # which type of instance
    instance_type = var.instance_type
 
    # add a public ip to this instance
    associate_public_ip_address = var.associate_public_ip_address
 
    # name the instance tech511-ramon-tf-test-vm
    tags = {
        Name = var.instance_name
    }

    # create the security group
    #security_groups = ["aws_security_group.test_sg"]
    #vpc_security_group_ids = "USE_VPC_ID"
}

# Create an AWS security group named techxxx-name-tf-allow-port-22-3000-80 (tf so you know it was created by Terraform)




# Modify the EC2 instance created in main.tf:
# Attach the key to be used with EC2 instance
# Use security group you created
# Test infrastructure was created as intended