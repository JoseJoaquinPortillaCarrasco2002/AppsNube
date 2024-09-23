output "instance_id" {
    description = "id de mi EC2 creado"
    value = aws_instance.portillainstancia.id
}

output "instance_public_id" {
    description = "ip publica de EC2"
    value = aws_instance.portillainstancia.public_ip
}