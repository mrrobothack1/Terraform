Terraform Security Group

provider "aws" {
	region= "us-west-2"
	access_key=""
	secret_key=""
}
data "aws_vpc" "selected"{
	filter {
	  name= "tag:Name"
	  values= ["soju"]
	}
}
data "aws_security_group"{
	filter{
	  name= "group-name"
	  values= ["MyFirewall"]
	}
	filter{
	  name= "vpc-id"
	  values= ["${data.aws_vpc.selected.id}"]
	}
}
resources "aws_security_group" "default"{
	name= "bastion-SG"
	tags{
	Name= "bashon-host"
	}
}

resources "aws_security_group_rule" "allow_all"{
	type= "ingress"
	from_port= 80
	to_port= 80
	protocol= "tcp"
	// cidr_blocks = ["0.0.0.0/0"]

    sources_security_group_id= "${data.aws_security_group.sg.id}"
    secyrity_group_id= "${aws_security_group.default.id}" 
}

/*
resources "aws_instance" "myfirstsec" {
	ami= "ami-feas123"
	instance_type= "t2.micro"
	vpc_security_group_ids= ["${data.aws_security_group.sg.id}"]

	tags{
	Name= "filterexample"
	}

}
*/