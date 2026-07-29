# Fetch latest Ubuntu AMI
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# Create the EC2 Instance
resource "aws_instance" "monitoring_server" {
  ami                    = data.aws_ami.ubuntu_24_04.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  # Set the 30GB Root Volume
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "monitoring-server"
  }
}

# Assign an Elastic IP
resource "aws_eip" "monitoring_eip" {
  instance = aws_instance.monitoring_server.id
  domain   = "vpc"

  tags = {
    Name = "monitoring-server-eip"
  }
}