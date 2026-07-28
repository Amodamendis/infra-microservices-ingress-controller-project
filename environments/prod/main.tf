provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["${var.aws_region}a", "${var.aws_region}b"]
}

module "security_groups" {
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "iam_roles" {
  source = "../../modules/iam-roles"
}

module "ec2_ingress" {
  source               = "../../modules/ec2-ingress"
  subnet_id            = module.vpc.first_subnet_id  # Updated to use the first subnet
  sg_id                = module.security_groups.sg_id
  iam_instance_profile = module.iam_roles.instance_profile_name
}


module "eks" {
  source       = "../../modules/eks"
  cluster_name = "Microservices-app-cluster"
  subnet_ids   = module.vpc.subnet_ids
}

output "ingress_server_ip" {
  value = module.ec2_ingress.public_ip
}