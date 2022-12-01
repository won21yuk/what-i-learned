# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  # GCP에서 받은 서비스 계정키 파일(*.json)의 이름을 입력
  credentials = file("C:/practice/learn-terraform-gcp/terraform-practice-369907-098e7b100728.json")

  # 자신의 프로젝트 아이디 입력
  project = "terraform-practice-369907"
  region  = "asia-northeast3"
  zone    = "asia-northeast3-c"
}

# VPC 생성
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

# 인스턴스 생성
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
     initialize_params {
        image = "cos-cloud/cos-stable"
     }
   }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}