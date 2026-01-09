module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "v21.11.0"
  name    = local.cluster_name
  kubernetes_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  # Correct placement: top-level argument in the module block
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
    disk_size      = 50 # Default disk size for all managed groups
  }

  eks_managed_node_groups = {
    default_ng = {
      min_size = 1
      max_size = 3
      # Other specific settings for this node group
    }

    # Another node group, which will inherit defaults unless overridden
    another_ng = {
      instance_types = ["m5.large"] # Overrides the default instance type
    }
  }

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id

}

