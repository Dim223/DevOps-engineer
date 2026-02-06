resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.folder_id
  name           = "${ var.vpc_name }-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id  = var.folder_id
  name       = "${ var.vpc_name }-route-table" 
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

