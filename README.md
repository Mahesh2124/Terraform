# Terraform

Create a Role `test_role` with administrative permissions or the following permissions.

```json
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
```

And update the trust policy to assume this role.

Update `terraform.tfvars` according to your architecture.

Configure the backend before creating the infrastructure.

## Terraform Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan -var-file=terraform.tfvars -out=tfplan
terraform apply tfplan
terraform destroy
```

added the db passwd in aws secret manager. 