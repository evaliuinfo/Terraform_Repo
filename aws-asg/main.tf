provider "aws" {
  profile = "default"
  region  = "us-west-2"

  default_tags {
    tags = {
      Environment = "Test"
      Service     = "Example"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_default_tags" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "test_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a3a960ae2c38b6a6"
}

resource "aws_launch_template" "test_lt" {
  name_prefix   = "learn-terraform-aws-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "test_asg" {
  vpc_zone_identifier = ["subnet-0a3a960ae2c38b6a6"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
     id      = aws_launch_template.test_lt.id
     version = "$Latest"
  }
  
  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
