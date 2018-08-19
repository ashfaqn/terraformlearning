provider "aws" {
  region = "us-east-1"
}

variable "server_port" {
  description = "value of web server port"
  default = 8080
}

resource "aws_instance" "ubuntu" {
  ami = "ami-759bc50a"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "hello world" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform security group example"

  ingress{
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "public_ip" {
  value = "${aws_instance.ubuntu.public_ip}"
}
