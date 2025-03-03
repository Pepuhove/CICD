variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  default     = "my-app-repo"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "my-ecs-cluster"
}