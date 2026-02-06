resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop-a" {
  name           = "${ var.vpc_name }-central1-a"
  zone           = "${ var.default_zone }-a"
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.rt.id 
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "${ var.vpc_name }-central1-b"
  zone           = "${ var.default_zone }-b"
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

resource "yandex_compute_instance" "platform-web-a" {
  name        = local.web_name
  platform_id = var.vm_web_instance_platform_id 
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_instance_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = false
#    nat       = var.vm_web_instance_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys 
  }

}

resource "yandex_compute_instance" "platform-db-b" {
  name        = local.db_name
  platform_id = var.vm_db_instance_platform_id 
  zone = "ru-central1-b"

  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_instance_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = false
#    nat       = var.vm_db_instance_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys 
  }

}

