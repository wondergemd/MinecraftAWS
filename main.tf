terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "mykey"
  public_key = tls_private_key.keypair.public_key_openssh
}



resource "aws_security_group" "minecraft_ingress" {
	description	= "minecraft server"
  ingress {
    description = "minecraft_ingress_rule"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
	protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
	from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "minecraft_server" {
  ami           = "ami-04e914639d0cca79a"
  instance_type = "t2.small"
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_ingress.id]
  
  provisioner "file" {
    source      = "~/minecraftAWS/minecraft_setup.sh"
    destination = "/home/ec2-user/minecraft_setup.sh"
  }
  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ./minecraft_setup.sh",
      "sudo ./minecraft_setup.sh",
    ]
  }
  
  connection {
	user = "ec2-user"
	type = "ssh"
	private_key = tls_private_key.example.private_key_pem
	host = aws_instance.minecraft_server.public_ip
  }
  
}

