provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "redhat" {
  ami = "ami-6871a115"
  instance_type = "t2.micro"

  tags {
    Name = "terraform-example"
  }

}
