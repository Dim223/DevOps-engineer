
variable "web_instance_name" {
  type        = string
  default     = "netology-develop-example-web"
  description = "instance name"
}

variable "web_vms_resources" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
    size          = 15
  }
}

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpsOZImdchIuYFtYz7iGIYnqpeWBfbHGjuh1RwlX3DY/xqFVwFYNdGXLitO0wNa4nL8BhPdMJUUa7WullBZiP9a35ghappuT0PGDv2ob8JKPHyYC/pmcdRGe7ZmgMnlvP7msge/LotVaoXTVvs85o7wB3E+0wuGlRnEHo99BagBVLrhhLaSysg2PHRo4z1P+bUKg99de8dVOxqfNWrcTZfGoJ0ozPorPoNXgeGoNKRszE4hTrFeqpxhQN/5YqDmq1No6XX4oQ1PK/Buq7L+t7cFqoBMqeb659tOKH1DpevkK8gDgQtRE1cbA1bN5E4VtwcCHUgLumn4ZEQmTeUde5Ha6eyNvy1FtYQqj71sETAC7sFCMq9zZmpTVdwFnBwCHLXGmOxCoBGG1ZK3doC1ytM7FFU+o5DimiqeyN6PlhOwwqRl13dysUhiboaE8c5DGtxhoTDCaZRDyNxRD55UtMTvoYLfl2ZtMDekTl/sF0AJZYJtDelcL60nhheu7C/3XNckvNfdoQBPQFfo1XxN2NqDniswXJUDsf3wt1az0TRfV7omvIHwNCqSC/reUpuXoBjF2zF4w4sOjRBsDJrfZGLjZQvyA7SoZrNM2V7cPWfdl0DebWqFd3S9JRWea0H2y27ffshNQr743Zty11EBaQQ+1Aigb7hZkYLQK6ecGRa4Q== dim22@debian-test"
  }
}



resource "yandex_compute_instance" "example-web" {
  depends_on = [yandex_compute_instance.example-db]

  count = 2

  name     = "${var.web_instance_name}-${count.index + 1}"
  hostname = "${var.web_instance_name}-${count.index + 1}"

  resources {
    cores         = var.web_vms_resources.cores
    memory        = var.web_vms_resources.memory
    core_fraction = var.web_vms_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size     = var.web_vms_resources.size
    }
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }
}
