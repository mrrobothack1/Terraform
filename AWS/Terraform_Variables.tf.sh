Terraform Variables | 

main.tf

provider "aws" {
	region= "${var.region}"
	access_key=""
	secret_key=""
}

resource "aws_instance" "myfirstec2"{
	ami= ""
	instance_id= "t2.micro"
	vpc_security_group_ids= ["${aws_security_group.instance.id}"]
   
   tags {
     Name="terraform-myfirstsec2"
   }
}


resources "aws_security_group_rule" "instance"{

    ingress {
    from_port= 80
	to_port= 80
	protocol= "tcp"
	cidr_blocks = ["0.0.0.0/0"]
    }
}

variable.tf 
 
 variable "region" {
   default ="ap-south-1"
 }

 variable "web_server_port" {
  description= "port the server will use for htto request"
 }