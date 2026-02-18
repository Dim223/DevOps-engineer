resource "local_file" "hosts_templatefile" {

  content = templatefile("${path.module}/hosts.tftpl",

    { webservers = yandex_compute_instance.example-web,
      databases  = yandex_compute_instance.example-db,
      storage    = yandex_compute_instance.example-storage
  })

  filename = "${abspath(path.module)}/hosts.ini"
}
