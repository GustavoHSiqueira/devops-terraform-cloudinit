output "vm_name" {
  description = "Nome da VM criada"
  value       = multipass_instance.devops.name
}

output "vm_ip" {
  description = "Endereços IP da VM"
  value       = multipass_instance.devops.ipv4
}