provider "aws" {
  region = "sa-east-1"
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFdhihtJ/ihWPMJsb8ynlLYbzetYpfrlkcSL5Bca92qxq4XRZ8UFLOu9G4CxpbHUNaA3BL0CbrtrGMonOyWqlT8CPzcbNehO6FRPn0aQpkljdJOVJb+yv4suSH504BRpxHYW8ZF2WAcND8g5/ojeyu97qOSBtkE+oBjCA5VoT3DvJINZIJ86Ec1ns/wAGq/VcefbkPkYWD3s9o34vMrDaYYezYLzVUThxntB1ZO0mrXM0KM/vY3L67PDoCFEvK3JwVvl4koajey+j4M+aprN8IA29Hd1RwvhFsS4Qturqk2gnctQamyFYjmGskUhiuhGaAQcRGfG9VqFn3sMJ4GA8UbSgeSPSrutGwa6DLGmvTJcORS9v786P7VxvDNGXJfpRZheZUnQgNscAR7MH9HldpijmFrMetjfcb5dLidxW9RRiMfR3kfyW0mO5M6GriPjqNH9cTbZGaDYphir23MS+0tSANR2mHR+ECrpaXOpykMzZGg4QxJTQpd/ljESg05xk= ubuntu@i-09aed0533d7441e77"
}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "kubernetes-worker" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 2
  tags = {
    name = "k8s"
    type = "worker"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 1
  tags = {
    name = "k8s"
    type = "master"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

