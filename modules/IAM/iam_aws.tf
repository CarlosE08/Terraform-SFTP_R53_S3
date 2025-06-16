
############################ IAM Role for SFTP only-write User ################################

resource "aws_iam_role" "user_onlywrite" {
  name = "sftp-user-onlywrite"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = merge(var.common_tags, {
    #Name = "VPC-${local.generate_name}"
    Ambiente = "${terraform.workspace}"
  })
}

resource "aws_iam_role_policy" "user_onlywrite_policy" {
  name = "sftp-user-onlywrite-policy"
  role = aws_iam_role.user_onlywrite.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadWriteS3",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_name}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetObjectACL",
        "s3:PutObjectACL"
      ],
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
EOF
}

############################ IAM Role for SFTP admin User ################################

resource "aws_iam_role" "user_admin" {
  name = "sftp-user-admin"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = merge(var.common_tags, {
    #Name = "VPC-${local.generate_name}"
    Ambiente = "${terraform.workspace}"
  })
}

resource "aws_iam_role_policy" "user_admin_policy" {
  name = "sftp-user-admin-policy"
  role = aws_iam_role.user_admin.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadWriteS3",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_name}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
EOF
}