region                   = "us-east-1"
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
azs                     = ["us-east-1a", "us-east-1b"]
public_instance_ami      = "ami-04a81a99f5ec58529" # Replace with actual AMI ID
private_instance_ami     = "ami-04a81a99f5ec58529" # Replace with actual AMI ID
instance_type            = "t2.micro"
