Terraform EC2 User data Example
tera.tf 

provider "aws" {
	region= "${var.region}"
	access_key=""
	secret_key=""
}

resource "aws_instance" "myfirstec2"{
	ami= ""
	instance_id= "t2.micro"
	vpc_security_group_ids= ["${aws_security_group.instance.id}"]
	key_name= "vijay.jan-18"
	user_data= <<-EOF
				  $!/bin/bash
				  yum install httpd -y
				  echo "welcome to my furst instance" > /var/www/html/index.html
				  yum  update -y
				  service httpd start
				  EOF

tags {
	Name= "web-server"
 }
}

resource "aws_security_group" "instance" {
	name= "terraform-security-group"

	# Inbound HTTP from anywhere
  ingress {
     from_port= "${var.web_server_port}"
     to_port= "${var.web_server_port}"
     protocol= "tcp"
     cidr_blocks= ["0.0.0.0/0"]
  }
  ingress {
     from_port= 22
     to_port= 22
     protocol= "tcp"
     cidr_blocks= ["0.0.0.0/0"]
  }
  egress {
     from_port= 0
     to_port= 0
     protocol= "-1"
     cidr_blocks= ["0.0.0.0/0"]
  }
}

variable.tf

 
 variable "region" {
   default ="ap-south-1"
 }

 variable "web_server_port" {
    value-80
 }