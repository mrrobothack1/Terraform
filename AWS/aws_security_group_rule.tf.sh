
provider "aws" {
	region= "us-west-2"
	access_key=""
	secret_key=""
}

data "aws_vpc" "selected"{
	filter{
	  name= "tag:Name"
	  values= ["soju"]
	}
}

data "aws_security_group" "sg"{
	filter{
	  name= "group-name"
	  values= ["MyFirewall"]
	}
	filter{
	  name= "vpc-id"
	  values= ["{data.aws_vpc.selected.id}"]
	}
}

resource "aws_security_group_rule" "rule_update" {
     type= "ingress"
     from_port= 443
     to_port= 443
     protocol= "tcp"
     cidr_blocks= ["0.0.0.0/0"]

     security_group_id= "${data.aws_security_group.sg.id}"
 }