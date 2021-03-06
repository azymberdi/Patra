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
  vpc_security_group_ids = ["${aws_security_group.allow.id}"]
  #vpc_security_group_ids = ["sg-xxxx"]
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
  cidr_block = "10.1.0.0/16"
}


resource "aws_security_group" "allow" {
  name        = "Patraallowit"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "TLS from VPC"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
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


# # Public Subnet
# ########################################################
resource "aws_subnet" "public1" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-west-2a"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "public2" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "10.1.2.0/24"
    availability_zone = "us-west-2b"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "public3" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "10.1.3.0/24"
    availability_zone = "us-west-2c"
    map_public_ip_on_launch = true
}





