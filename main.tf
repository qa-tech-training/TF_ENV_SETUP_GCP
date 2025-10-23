terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.7.0"
    }
  }
}

provider "google" {
  project     = "qwiklabs-gcp-XX-XXXXXXXXXXXX"
  region      = "europe-west1"
}

module "network" {
  source = "./network"
  network_name = "lab4-vpc"
  region = "europe-west1"
  allowed_ports = ["22", "80", "8080", "8081"]
  ip_cidr_range = "10.0.0.0/24"
}

module "instance1" {
  count = 2
  source = "./instance"
  region = "europe-west1"
  subnet_name = module.network.subnet_name
  machine_type = "e2-medium"
  instance_name = "app-server-${count.index}"
  role = "appserver"
}

module "instance2" {
  source = "./instance"
  region = "europe-west1"
  subnet_name = module.network.subnet_name
  machine_type = "e2-medium"
  instance_name = "proxy-server"
  role = "proxy"
}

