module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "v21.11.0"
  name    = local.cluster_name
  kubernetes_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets
  enable_irsa = true
  eks_managed_node_groups = {
    default = {
      min_size = 1
      max_size = 5
      desired_size = 3
      instance_types = ["t3.large"]
    }
  }

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id

}

