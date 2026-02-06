variable "instance_name" {
  type        = string
  default     = "netology-develop-platform"
  description = "instance name"
}

###vm_web vars
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image famaly"
}

variable "web_instance_name" {
  type        = string
  default     = "web"
  description = "web instance name"
}

variable "vm_web_instance_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "platform id"
}

/*
variable "vm_web_instance_cores" {
  type        = number
  default     = 2
  description = "instance cores"
}

variable "vm_web_instance_memory" {
  type        = number
  default     = 1
  description = "instance memory"
}

variable "vm_web_instance_core_fraction" {
  type        = number
  default     = 20
  description = "instance core fraction"
}
*/

variable "vm_web_instance_preemptible" {
  type        = bool
  default     = true
  description = "instance preemptible"
}

variable "vm_web_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "instance nat"
}


###vm_db vars

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image famaly"
}

variable "vm_db_instance_name" {
  type        = string
  default     = "db"
  description = "db instance name"
}

variable "vm_db_instance_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "platform id"
}

/*
variable "vm_db_instance_cores" {
  type        = number
  default     = 2
  description = "instance cores"
}

variable "vm_db_instance_memory" {
  type        = number
  default     = 2
  description = "instance memory"
}

variable "vm_db_instance_core_fraction" {
  type        = number
  default     = 20
  description = "instance core fraction"
}
*/

variable "vm_db_instance_preemptible" {
  type        = bool
  default     = true
  description = "instance preemptible"
}

variable "vm_db_instance_network_interface_nat" {
  type        = bool
  default     = true
  description = "instance nat"
}


variable "vms_resources" {
  type = map(map(number))
  default = {
    web={
      cores         = 2
      memory        = 1
      core_fraction = 20
    },
    db= {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpsOZImdchIuYFtYz7iGIYnqpeWBfbHGjuh1RwlX3DY/xqFVwFYNdGXLitO0wNa4nL8BhPdMJUUa7WullBZiP9a35ghappuT0PGDv2ob8JKPHyYC/pmcdRGe7ZmgMnlvP7msge/LotVaoXTVvs85o7wB3E+0wuGlRnEHo99BagBVLrhhLaSysg2PHRo4z1P+bUKg99de8dVOxqfNWrcTZfGoJ0ozPorPoNXgeGoNKRszE4hTrFeqpxhQN/5YqDmq1No6XX4oQ1PK/Buq7L+t7cFqoBMqeb659tOKH1DpevkK8gDgQtRE1cbA1bN5E4VtwcCHUgLumn4ZEQmTeUde5Ha6eyNvy1FtYQqj71sETAC7sFCMq9zZmpTVdwFnBwCHLXGmOxCoBGG1ZK3doC1ytM7FFU+o5DimiqeyN6PlhOwwqRl13dysUhiboaE8c5DGtxhoTDCaZRDyNxRD55UtMTvoYLfl2ZtMDekTl/sF0AJZYJtDelcL60nhheu7C/3XNckvNfdoQBPQFfo1XxN2NqDniswXJUDsf3wt1az0TRfV7omvIHwNCqSC/reUpuXoBjF2zF4w4sOjRBsDJrfZGLjZQvyA7SoZrNM2V7cPWfdl0DebWqFd3S9JRWea0H2y27ffshNQr743Zty11EBaQQ+1Aigb7hZkYLQK6ecGRa4Q== dim22@debian-test"
  }
}