

locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

variable "each_vm" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = number
  }))
  default = [
    {
      vm_name       = "netology-develop-example-main"
      cpu           = 4
      ram           = 4
      disk_volume   = 25
      core_fraction = 20
    },
    {
      vm_name       = "netology-develop-example-replica"
      cpu           = 2
      ram           = 2
      disk_volume   = 20
      core_fraction = 20
    }
  ]
}



resource "yandex_compute_instance" "example-db" {

  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name     = each.value.vm_name
  hostname = each.value.vm_name

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size     = each.value.disk_volume
    }
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
}


