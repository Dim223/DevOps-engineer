output "vm_list" {
  value = concat(
    [for vm in yandex_compute_instance.example-web : {
      "name" = vm.name,
      "id"   = vm.id,
      "fqdn" = vm.fqdn
    }],
    [for vm in yandex_compute_instance.example-db : {
      "name" = vm.name,
      "id"   = vm.id,
      "fqdn" = vm.fqdn
    }],
    [for vm in [yandex_compute_instance.example-storage] : {
      "name" = vm.name,
      "id"   = vm.id,
      "fqdn" = vm.fqdn
    }]
  )
}

