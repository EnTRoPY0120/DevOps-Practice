provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


resource "aws_instance" "variable" {
  count = length(var.size)
  ami           = var.images["opensuse"]
  instance_type = var.size[count.index]["small"]
}

resource "aws_s3_bucket" "variable_s3_bucket" {
  bucket = var.bucket_name
}
