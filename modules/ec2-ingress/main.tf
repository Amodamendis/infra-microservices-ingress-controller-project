data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ingress_server" {
  ami                  = data.aws_ami.ubuntu_24_04.id
  instance_type        = "t2.large"
  subnet_id            = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  iam_instance_profile = var.iam_instance_profile

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "Ingress-Server"
  }
}

resource "aws_eip" "ingress_eip" {
  instance = aws_instance.ingress_server.id
  domain   = "vpc"

  tags = {
    Name = "ingress-eip"
  }
}