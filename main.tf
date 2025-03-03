resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository" "repo" {
  name = var.ecr_repository_name
}

resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family                   = "my-app-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "my-app",
      "image": "${aws_ecr_repository.repo.repository_url}:latest",
      "memory": 512,
      "cpu": 256,
      "essential": true
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name            = "my-app-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
}