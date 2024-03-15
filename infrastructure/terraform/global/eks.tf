resource "aws_eks_cluster" "eks_prod" {
  name     = "eks-prod"
  role_arn = var.lab_role

  version = "1.29"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_az1.id,
      aws_subnet.public_subnet_az2.id,
      aws_subnet.private_subnet_az1.id,
      aws_subnet.private_subnet_az2.id
    ]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

}

resource "aws_eks_node_group" "eks_prod_ng" {
  cluster_name    = aws_eks_cluster.eks_prod.name
  node_group_name = "eks-prod-ng"
  node_role_arn   = var.lab_role
  subnet_ids = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id,
    aws_subnet.private_subnet_az1.id,
    aws_subnet.private_subnet_az2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.eks_prod.identity[0].oidc[0].issuer
# }

# resource "aws_iam_openid_connect_provider" "eks" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.eks_prod.identity[0].oidc[0].issuer
# }

output "endpoint" {
  value = aws_eks_cluster.eks_prod.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_prod.certificate_authority[0].data
}