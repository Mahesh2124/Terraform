
resource "aws_security_group" "rds" {
  description = "Allow PostgreSQL only from application EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from application EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }


  tags = {
    Name        = "${var.env}-rds-sg"
    Environment = var.env
  }
}


resource "aws_db_subnet_group" "main" {
  name = "${var.env}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.env}-db-subnet-group"
    Environment = var.env
  }
}


resource "aws_db_instance" "main" {
  identifier = "${var.env}-postgres"

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class = var.db_instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  port     = 5432
  manage_master_user_password = true
  multi_az = var.multi_az

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false

  backup_retention_period = 7
  backup_window           = "18:00-19:00"

  maintenance_window = "Sun:19:00-Sun:20:00"

  auto_minor_version_upgrade = true

  enabled_cloudwatch_logs_exports = [
    "postgresql",
    "upgrade"
  ]

  deletion_protection = true
  skip_final_snapshot = false

  final_snapshot_identifier = "${var.env}-postgres-final"

  performance_insights_enabled = false

  tags = {
    Name        = "${var.env}-postgres"
    Environment = var.env
  }
  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    aws_db_subnet_group.main
  ]
}