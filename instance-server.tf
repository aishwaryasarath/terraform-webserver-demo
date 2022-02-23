terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}


resource "aws_security_group" "Webserver-demo" {
  name        = "Webserver-demo"
  description = "Allow ssh, https & http traffic"


  ingress {
    description      = "allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "Webserver-instance" {

  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  security_groups = ["${aws_security_group.Webserver-demo.name}"]

  key_name = "terra-udemy"
  user_data = <<-EOF
          #! /bin/bash
          sudo yum update -y
          sudo yum install httpd -y
          sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "<h1>Sample webserver created using terraform on aws instance</h1>">> /var/www/html/index.html
  EOF
  tags = {
    Name = "webserver-instance-demo"
  }
}
