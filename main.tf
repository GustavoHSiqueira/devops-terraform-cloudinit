provider "multipass" {
  command_timeout = 600
  default_image   = "24.04"
}

resource "multipass_instance" "devops" {
  name   = var.vm_name
  image  = "24.04"
  cpus   = var.vm_cpus
  memory = var.vm_memory
  disk   = var.vm_disk

  cloud_init_file = "${path.module}/user-data.yaml"
}