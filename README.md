# Terraform
create a Role "test_role" with administrative permissions or following permissions.

{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"s3:*",
				"rds:*",
				"ec2:*",
				"autoscaling:*",
				"iam:*",
				"ssm:*",
				"elasticloadbalancing:*",
				"cloudwatch:*",
        "dynamodb:*" 
			],
			"Resource": "*"
		}
	]
}

and update the trust policy to assume this role.

update terraform.tfvars according to your architecture.

configure the backend before creating the infrasture.

**terraform commands**
terraform init
terraform fmt
terraform validate
terraform plan -var-file=terraform.tfvars -out=tfplan
terraform apply tfplan
terraform destroy
