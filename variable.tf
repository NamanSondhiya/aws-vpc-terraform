variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "env" {
  type    = string
  default = "dev" # can be dev, prod, stg
}


# variable "access_key" {
#   description = "AWS Access Key ID"
#   type        = string
#   default     = "YOUR_ACCESS_KEY_HERE"
# }

# variable "secret_key" {
#   description = "AWS Secret Access Key"
#   type        = string
#   default     = "YOUR_SECRET_KEY_HERE"
# }