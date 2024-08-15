variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "images" {
  type = map(string)
  default = {
    debian   = "ami-00402f0bdf4996822"
    red_hat  = "ami-0583d8c7a9c35822c"
    opensuse = "ami-0b247d4d0226ca7cd"
    ubuntu   = "ami-04a81a99f5ec58529"
  }
}

variable "size" {
  type = list(map(string))
  default = [
    {
      "tiny"   = "t2.nano"
      "small"  = "t2.micro"
      "medium" = "t2.medium"
    }
  ]
}

variable "bucket_name" {
  description = "bucket name in which you want to create"
}
