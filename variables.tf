variable "vm_name" {
  description = "Nome da máquina virtual"
  type        = string
  default     = "devops-lab"
}

variable "vm_cpus" {
  description = "Quantidade de CPUs da VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memória RAM da VM"
  type        = string
  default     = "2G"
}

variable "vm_disk" {
  description = "Espaço em disco da VM"
  type        = string
  default     = "12G"
}