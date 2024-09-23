terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

#definiendo a AWS y dandole una variable var. para la "region"
#se usa con variables.tf para dar un mejor uso cuando se use "region" en un futuro

provider "aws" {
  region = var.region_portillavar
}



resource "aws_security_group" "web" {
  name         = "portillainstancia_sg"
  description  = "recurso para acceder por ssh y http"
  #se definen reglas de entrada para la instancia

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #se define la regla de salida
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#crear instancia EC2
resource "aws_instance" "portillainstancia" {
    ami            = "ami-07caf09b362be10b8"
    instance_type  = "t2.micro"
    security_groups = [aws_security_group.web.name]

    tags = {
      Name = "CarrascoPortillaInstancia"
    }

    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start htppd
                systemctl enable httpd
                echo "<h1> Hola mundo desde $(hostname -f)</h1>" > /var/www/html/index.html
                EOF
}