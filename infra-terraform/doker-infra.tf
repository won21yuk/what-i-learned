# doker-infra.tf

terraform {
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "3.5.0"
        }
    }
}

provider "google" {
    credentials = file(var.credentials_file)
    project = var.project
    region  = var.region
    zone    = var.zone
}

# VPC 생성 및 서브넷 생성
resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
}

# 인스턴스 생성
resource "google_compute_instance" "vm_instance" {
  name         = "docker-instance"
  machine_type = "e2-medium"
  tags         = ["custom-ssh", "custom-httpd", "custom-http-server", "custom-https-server", "custom-internal"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20221102"
    }
  }

  metadata_startup_script = "sudo yum -y update; ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime; yum install -y net-tools vim unzip curl gcc openssl-devel wget utils yum-utils; sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo; sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin"
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "custom-ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.name
  priority      = 1000
  source_ranges = ["125.177.169.158/32"]
  target_tags   = ["custom-ssh"]
}

resource "google_compute_firewall" "custom-httpd" {
  name    = "allow-httpd"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  direction = "INGRESS"
  source_ranges = ["125.177.169.158/32"]
  target_tags = ["custom-httpd"]
}

resource "google_compute_firewall" "custom-http-server" {
  name        = "allow-http"
  network     = google_compute_network.vpc_network.name
  description = "http 연결"

  allow {
    protocol  = "tcp"
    ports     = ["80"]
  }
  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["custom-http-server"]
}

resource "google_compute_firewall" "custom-https-server" {
  name        = "allow-https"
  network     = google_compute_network.vpc_network.name
  description = "https 연결"

  allow {
    protocol  = "tcp"
    ports     = ["443"]
  }
  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["custom-https-server"]
}

resource "google_compute_firewall" "custom-internal" {
  name        = "my-internal"
  network     = google_compute_network.vpc_network.name
  description = "내부 인스턴스 연결"

  allow {
    protocol  = "tcp"
    ports     = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "udp"
    ports = ["0-65535"]
  }
  direction = "INGRESS"
  source_ranges = ["10.128.0.0/9"]
  target_tags = ["custom-internal"]
}