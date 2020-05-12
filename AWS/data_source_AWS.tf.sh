Terraform data source examples

provider "aws" {
	region= "us-west-2"
	access_key=""
	secret_key=""
}
data "aws_caller_identify" "current" {}

out "account_id" {
	value= "${data.aws_caller_identify.current,account_id}"
}
data "aws_vpc" "selected" {
	filter{
		name= "tag.Name"
		values= {"soju"}
	}
}
data "aws_security_group" "sg" {
	filter {
		name= "group-name"
		values= ["MyFirewall"]
	}
	filter {
		name= "vpc-id"
		values= "${data.aws_vpc.selected.id}"
	}
}
resource "aws_instance" "myfirstec2". {
	ami =""
	instance_type= ""
	vpc_securtiy_group_ids=["${data.aws_security_group.sg.id}"]

	tags {
		name= "example"
	}
}

output "aws_vpc_id" {
	value="${data.aws_vpc.selected.id}"
}