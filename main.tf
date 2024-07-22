provider "aws" {
    region = "us-east-1"  
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-04a81a99f5ec58529" 
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
