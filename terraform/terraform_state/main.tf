resource "aws_instance" "ec2_instances" {
  ami           = "ami-00402f0bdf4996822"
  instance_type = "t2.micro"
  tags = {
    Name = "Staging"
  }
}

output "example" {
  value = aws_instance.ec2_instances.public_ip
}
