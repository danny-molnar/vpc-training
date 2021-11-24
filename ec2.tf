resource "aws_security_group" "my_app_sg" {
  name        = "my_app_sg"
  description = "Allow access to my Server"
  vpc_id      = aws_vpc.main_vpc.id

    # INBOUND RULES
  ingress {
    description      = "SSH from my mac"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["2.100.117.87/32"]
  }

  tags = {
    Name = "my_app_sg"
  }
}

data "aws_ami" "my_aws_ami" {
    owners = ["137112412989"]
    most_recent = true
    filter {
        name = "name"
        values = [ "amzn2-ami-kernel-*" ]
    }
}

# EC2
resource "aws_instance" "my_first_server" {
    ami = data.aws_ami.my_aws_ami.id
    instance_type = var.instance_type
    key_name = var.keypair_name
    subnet_id = aws_subnet.private_a.id
    security_groups = [ aws_security_group.my_app_sg.id ]
}

# AMI ID
# INSTANCE TYPE
# KEYPAIR
# SUBNET - Private
# SECURITY GROUPS
# USER-DATA template (optional)

# TASK:
# NEW EC2 in Public subnet - almost the same but the line should be saying subnet_id = aws_subnet.public_a.id
# Check the public IP Address exists or add the EIP to the server - adding eip
# SSH using the keypair to the new public server - in the cli
# Try to copy your private key to the public server and connect to the private server. - cli?
