resource "aws_instance" "Local-provisioner" {
  ami           = "ami-00402f0bdf4996822"
  instance_type = "t2.micro"
  tags = {
    Name = "local-exec"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo ${self.id} Debian VM deleted successfully >> myVMid"
  }
}
