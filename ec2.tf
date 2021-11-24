# Creating security group

resource "aws_security_group" "my_app_sg" {
  name        = "my_app_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description      = "SSH from my mac"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["2.100.117.87/32"] # this is my local IP, googled it, and added 32 cidr at the end
  }

  tags = {
    Name = "allow_tls"
  }
}

# Data source for AMI

data "aws_ami" "my_aws_ami" {
    most_recent = true
    owners = ["137112412989"]
    filter {
        name = "name"
        values = [ "amzn2-ami-kernel-*" ]
    }
}

# Creating default ec2 instance

/* resource "aws_instance" "my-ec2-instance" {
    ami = data.aws_ami.my_aws_ami.id
} */
