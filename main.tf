resource "aws_s3_bucket" "s3_service_bucket" {
  bucket = "${local.s3_service_name}-bkt"
}

resource "aws_sqs_queue" "sqs_service_queue" {
  name = "${local.sqs_service_name}-queue"
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "${local.prefix}-multiservice-ecs"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    (local.s3_service_name) = {
      cpu    = 512
      memory = 1024
      container_definitions = {
        (local.s3_container_name) = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${aws_ecr_repository.s3_service.name}:latest"
          port_mappings = [
            {
              containerPort = 5001
              protocol      = "tcp"
            }
          ]
          environment = [
            {
              name  = "AWS_REGION"
              value = local.aws_region
            },
            {
              name  = "BUCKET_NAME"
              value = aws_s3_bucket.s3_service_bucket.bucket
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = module.vpc.public_subnets # Correctly reference public subnets
      security_group_ids                 = [module.s3_service_sg.security_group_id]
      create_tasks_iam_role              = false
      tasks_iam_role_arn                 = module.s3_service_task_role.iam_role_arn
    }

    (local.sqs_service_name) = {
      cpu    = 512
      memory = 1024
      container_definitions = {
        (local.sqs_container_name) = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${aws_ecr_repository.sqs_service.name}:latest"
          port_mappings = [
            {
              containerPort = 5002
              protocol      = "tcp"
            }
          ]
          environment = [
            {
              name  = "AWS_REGION"
              value = local.aws_region
            },
            {
              name  = "QUEUE_URL"
              value = aws_sqs_queue.sqs_service_queue.name
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = module.vpc.public_subnets # Correctly reference public subnets
      security_group_ids                 = [module.sqs_service_sg.security_group_id]
      create_tasks_iam_role              = false
      tasks_iam_role_arn                 = module.sqs_service_task_role.iam_role_arn
    }
  }
}