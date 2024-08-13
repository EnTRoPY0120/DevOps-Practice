resource "aws_instance" "ec2-remote" {
  ami                    = "ami-00402f0bdf4996822"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ssh.key_name
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.prov_fw.id]
}

resource "aws_key_pair" "ssh" {
  key_name   = "provision_key"
  public_key = file("terraform_prov.pub")
}

resource "aws_security_group" "prov_fw" {
  name = "prov_fw"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "prov_null" {
  depends_on = [aws_instance.ec2-remote]

  triggers = {
    public_ip = aws_instance.ec2-remote.public_ip
  }

  connection {
    type        = "ssh"
    host        = aws_instance.ec2-remote.public_ip
    private_key = file("terraform_prov")
    user        = "admin"
    timeout     = "2m"
    agent       = false
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable --now nginx",
      "echo '<!doctype html><html><body><h1> Hello hi there Congrats you have successfully configured your remote execution provisioner!!!</h1></body></html>' | sudo tee /var/www/html/index.html"
    ]
  }
}
