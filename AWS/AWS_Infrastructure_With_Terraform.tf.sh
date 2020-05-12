Create AWS Infrastructure With Terraform | VPC | Subnet | EC2 | 

provider "aws" {
	region= "us-west-2"
	access_key=""
	secret_key=""
}

data "aws_vpc" "myVPC"{
      cidr_block= "10.0.0.0/16"
	  instance_tenancy= "dedicated" 
	  
	tags {
	  Name= "MYVPC"
	}
}