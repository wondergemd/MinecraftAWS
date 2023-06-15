output "public_ip" {
  description = "Public IP address of the minecraft server"
  value       = aws_instance.minecraft_server.public_ip
}

output "private_key" {
  value     = tls_private_key.keypair.private_key_pem
  sensitive = true
}
