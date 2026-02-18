
variable "secondary_disks" {
  description = "secondary disks resources "
  type = object({
    name = string
    zone = string
    type = string
    size = number
  })
  default = {
    name = "secondary-disk"
    zone = "ru-central1-a"
    type = "network-hdd"
    size = 1
  }
}

variable "example-storage" {
  description = "example-storage resources "
  type = object({
    name          = string
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
  })
  default = {
    name          = "netology-develop-example-storage"
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_volume   = 10
  }
}

locals {
  disk_ids = yandex_compute_disk.secondary_disk[*].id
}

resource "yandex_compute_disk" "secondary_disk" {
  count = 3

  name = "${var.secondary_disks.name}-${count.index + 1}"
  zone = var.secondary_disks.zone

  type = var.secondary_disks.type
  size = var.secondary_disks.size
}

resource "yandex_compute_instance" "example-storage" {
 
  name       = var.example-storage.name
  hostname   = var.example-storage.name

  resources {
    cores         = var.example-storage.cores
    memory        = var.example-storage.memory
    core_fraction = var.example-storage.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size     = var.example-storage.disk_volume
    }
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  dynamic "secondary_disk" {
    for_each = toset(local.disk_ids)

    content {
      disk_id     = secondary_disk.value
      auto_delete = true
    }
  }
}
