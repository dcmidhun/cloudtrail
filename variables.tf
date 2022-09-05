variable "aws_region" {
  description = "The aws region in which the resource would be created"
  type = string
  default =  "us-east-1"
}

variable "cloudtrail_name" {
  description = "The name of the cloudtrail resource"
  type = string
  default =  "measured-cloudtrail-events"
}

variable "bucket_name" {
  description = "The name of the s3 bucket"
  type = string
  default =  "measured-cloudtrail-logs"
}

variable "clientNameTag" {
  description = "Descriptor for Tag key used in resources."
  default     = ""
}

variable "processOwnerTag" {
  description = "Descriptor for Tag key used in resources."
  default     = ""
}

variable "projectName" {
  description = "Descriptor for Tag key used in resources."
  default     = ""
}

variable "env" {
  description = "Descriptor for environmnet Tag key used in resources."
  default     = "te"
}
