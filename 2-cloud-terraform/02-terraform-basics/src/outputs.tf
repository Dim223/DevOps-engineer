output "vm" {

  value = [
    { web = ["NAME = ${yandex_compute_instance.platform-web-a.name}", "IP = ${yandex_compute_instance.platform-web-a.network_interface[0].nat_ip_address}", "FQDN = ${yandex_compute_instance.platform-web-a.fqdn}"] },
    { db = ["NAME = ${yandex_compute_instance.platform-db-b.name}", "IP = ${yandex_compute_instance.platform-db-b.network_interface[0].nat_ip_address}", "FQDN = ${yandex_compute_instance.platform-db-b.fqdn}"] }
  ]
}