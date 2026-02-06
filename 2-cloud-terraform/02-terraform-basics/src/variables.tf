###cloud vars

variable "cloud_id" {
  type        = string
  default     = "b1g59vdbg98t7cpkjdfh"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g7hd778785pkghfdd"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network "
}

/*
variable "vpc_name-central1-a" {
  type        = string
  default     = "develop-central1-a"
  description = "subnet central1-a name "
}

variable "vpc_name-central1-b" {
  type        = string
  default     = "develop-central1-b"
  description = "subnet central1-b name "
}
*/
###ssh vars

/*
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpsOZImdchIuYFtYz7iGIYnqpeWBfbHGjuh1RwlX3DY/xqFVwFYNdGXLitO0wNa4nL8BhPdMJUUa7WullBZiP9a35ghappuT0PGDv2ob8JKPHyYC/pmcdRGe7ZmgMnlvP7msge/LotVaoXTVvs85o7wB3E+0wuGlRnEHo99BagBVLrhhLaSysg2PHRo4z1P+bUKg99de8dVOxqfNWrcTZfGoJ0ozPorPoNXgeGoNKRszE4hTrFeqpxhQN/5YqDmq1No6XX4oQ1PK/Buq7L+t7cFqoBMqeb659tOKH1DpevkK8gDgQtRE1cbA1bN5E4VtwcCHUgLumn4ZEQmTeUde5Ha6eyNvy1FtYQqj71sETAC7sFCMq9zZmpTVdwFnBwCHLXGmOxCoBGG1ZK3doC1ytM7FFU+o5DimiqeyN6PlhOwwqRl13dysUhiboaE8c5DGtxhoTDCaZRDyNxRD55UtMTvoYLfl2ZtMDekTl/sF0AJZYJtDelcL60nhheu7C/3XNckvNfdoQBPQFfo1XxN2NqDniswXJUDsf3wt1az0TRfV7omvIHwNCqSC/reUpuXoBjF2zF4w4sOjRBsDJrfZGLjZQvyA7SoZrNM2V7cPWfdl0DebWqFd3S9JRWea0H2y27ffshNQr743Zty11EBaQQ+1Aigb7hZkYLQK6ecGRa4Q== dim22@debian-test"
  description = "ssh-keygen -t ed25519"
}
*/

