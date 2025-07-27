resource "aws_s3_bucket" "s3_service_bucket" {
  bucket = "${local.prefix}-s3-service-bkt"
}

resource "aws_sqs_queue" "sqs_service_queue" {
  name = "${local.prefix}-sqs-service-queue"
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
    ce10grp2-s3-service = {
      cpu    = 512
      memory = 1024
      container_definitions = {
        (local.s3_container_name) = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-s3-service-ecr:latest"
          port_mappings = [
            {
              containerPort = 5001
              protocol      = "tcp"
            }
          ]
          environment = [
            {
              name  = "AWS_REGION"
              value = "ap-southeast-1"
            },
            {
              name  = "BUCKET_NAME"
              value = "${local.prefix}-s3-service-bkt"
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

    ce10grp2-sqs-service = {
      cpu    = 512
      memory = 1024
      container_definitions = {
        (local.sqs_container_name) = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-sqs-service-ecr:latest"
          port_mappings = [
            {
              containerPort = 5002
              protocol      = "tcp"
            }
          ]
          environment = [
            {
              name  = "AWS_REGION"
              value = "ap-southeast-1"
            },
            {
              name  = "QUEUE_URL"
              value = "${local.prefix}-sqs-service-queue"
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