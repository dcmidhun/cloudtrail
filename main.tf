# Create cloudtrail events
resource "aws_cloudtrail" "measured-cloudtrail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.measured-cloudtrail-logs.id
  #s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

# Create an S3 bucket for cloudtrail logs
resource "aws_s3_bucket" "measured-cloudtrail-logs" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Create a S3 bucket policy for cloudtrail logs bucket
resource "aws_s3_bucket_policy" "measured-cloudtrail-bucket-policy" {
  bucket = aws_s3_bucket.measured-cloudtrail-logs.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.measured-cloudtrail-logs.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.measured-cloudtrail-logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

locals {
  tags = {
    Env          = var.env
    Project      = var.projectName
    Client       = var.clientNameTag
    ProcessOwner = var.processOwnerTag
  }
}
