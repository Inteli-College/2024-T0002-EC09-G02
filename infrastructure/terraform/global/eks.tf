resource "aws_eks_cluster" "eks_prod" {
  name     = "eks-prod"
  role_arn = "arn:aws:iam::916589015610:role/LabRole"

  version = "1.27"

  vpc_config {
    subnet_ids = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id, aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]
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
  cluster_name = aws_eks_cluster.eks_prod.name
  node_group_name = "eks-prod-ng"
  node_role_arn = "arn:aws:iam::916589015610:role/LabRole"
  subnet_ids = [ aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id, aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id ]

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }

  update_config {
    max_unavailable = 1
  }
}

output "endpoint" {
  value = aws_eks_cluster.eks_prod.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_prod.certificate_authority[0].data
}
