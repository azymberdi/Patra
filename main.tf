provider "aws" {
  region     = "us-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


#resource "aws_key_pair" "key" {
  #key_name   = "Bastion2565333"
  #public_key = "${file("~/.ssh/id_rsa.pub")}"
#}

data "template_file" "init" {
  template = "${file("${path.module}/userdata.sh")}"
}

resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = "ami-0d6621c01e8c2de2c"
  instance_type = "t2.micro"
  user_data       = "${base64encode(data.template_file.init.rendered)}"
  #vpc_security_group_ids = ["${aws_security_group.allow.id}"]
  vpc_security_group_ids = ["sg-0a02875f97061d24d"]
  #key_name = "${aws_key_pair.key.key_name}"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
  ]

  desired_capacity = "2"
  max_size         = "3"
  min_size         = "1"
 
  
launch_template  {
    id = "${aws_launch_template.example.id}"
    
    }
  }

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Patra"
  }
}




variable "access_key" {}
variable "secret_key" {}
#variable "aws_region" {}
#variable "tags" {}
#variable "public1_cidr" {}
#variable "public2_cidr" {}
#variable "public3_cidr" {}
#variable "region" {}
#variable "aws_region" {}


