resource "aws_security_group" "ingress_sg" {
  name        = "ingress-server-sg"
  description = "Security group for Ingress Server"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ingress-server-sg"
  }
}

resource "aws_security_group_rule" "eks_nodeport_ingress" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  
 
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
  description       = "Allow Kubernetes NodePort traffic from the internet"
}