
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] 
}

resource "aws_security_group" "ec2_sg" {
  name = "ec2-sg-${var.env}"
  description = "Security gorup to allow SSH and HTTP"
  vpc_id = var.vpc_id

    ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "Web Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-role-${var.subnet_id}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-profile-${var.subnet_id}"
  role = aws_iam_role.ssm_role.name
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.ec2_instance_type
    subnet_id =  var.subnet_id
    count = var.instance_count
    vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
    user_data = file("${path.module}/user_data.sh")
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    tags = {
        Name = "ec2-${var.env}"
    }  
    depends_on = [ aws_iam_role.ssm_role ]
}