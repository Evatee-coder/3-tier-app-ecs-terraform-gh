resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_iam_role_policy" "ecs_task_execution_role" {
  name = "${var.environment}-ecs_task_execution_policy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"  # Read-only instead of *
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",              # Read-only instead of *
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "*"
      }
    ]
  })
}

# role attachments with aws policys
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# resource "aws_iam_role_policy" "ecs_task_execution_role" {
#   name = "${var.environment}-ecs_task_execution_policy"
#   #name   = "${var.env}-${var.app_name}-ecs-task-execution-policy"
#   role   = aws_iam_role.ecs_task_execution_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ecr:GetAuthorizationToken",
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "secretsmanager:GetSecretValue"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }





















#### Akhilesh verison - previous code deleted ####



# data "aws_iam_policy_document" "ecs_task_execution_role" {
#   version = "2012-10-17"
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "${var.environment}-ecs-task-execution-role"
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
# }

# resource "aws_iam_role_policy" "ecs_task_execution_role" {
#   name = "${var.environment}-ecs_task_execution_policy"
#   role = aws_iam_role.ecs_task_execution_role.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#         "Effect": "Allow",
#         "Action": [
#             "ecr:GetAuthorizationToken",
#             "ecr:BatchCheckLayerAvailability",
#             "ecr:GetDownloadUrlForLayer",
#             "ecr:BatchGetImage",
#             "logs:CreateLogStream",
#             "logs:PutLogEvents"
#         ],
#         "Resource": "*"
#     },
#     {
#         "Effect": "Allow",
#         "Action": [
#             "secretsmanager:*"
#         ],
#         "Resource": [
#             "*"
#         ]
#     },
#     {
#         "Effect": "Allow",
#         "Action": [
#             "ssm:*"
#         ],
#         "Resource": "*"
#     }
#   ]
# }

# EOF
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }