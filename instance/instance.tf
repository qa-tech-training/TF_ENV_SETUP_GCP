resource "google_compute_instance" "vm2" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = "${var.region}-b"

  allow_stopping_for_update = true
  
  labels = {
    role = var.role
  }
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  
  metadata = {
    ssh-keys = "ansible:${file("/home/qa/.ssh/ansible_ssh_key.pub")}"
  }
  
  network_interface {
    subnetwork = var.subnet_name

    access_config {
      network_tier = "STANDARD"
    }
  }
}


