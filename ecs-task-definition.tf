resource "aws_ecs_task_definition" "test" {
  family                   = "splunk-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  task_role_arn            = aws_iam_role.ecs-efs-task-role.arn
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs-execution-role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "splunk",
    "image": "splunk/splunk",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8000
      }
    ],
    "environment" : [
      { "name" : "SPLUNK_START_ARGS", "value" : "--accept-license" },
      { "name" : "SPLUNK_PASSWORD", "value" : "Splunk-123" }
    ],
    "mountPoint" : [
      {
        "sourceVolume" : "etc",
        "containerPath" : "/opt/splunk/etc"
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  volume {
    name = "etc"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.splunk-efs.id
      transit_encryption      = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.splunk-ap.id
        iam             = "ENABLED"
      }
    }
  }
}