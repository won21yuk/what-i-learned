terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  # google에서 받은 서비스 계정키 파일(*.json)의 이름을 입력
  credentials = file(var.credentials_file)

  # 자신의 프로젝트 아이디 입력
  project = var.project
  region  = var.region
  zone    = var.zone
}

# VPC 생성
resource "google_compute_network" "practice_vpc" {
  name = "practice-vpc"
}

# SUBNET 생성
resource "google_compute_subnetwork" "practice_subnet1" {
  ip_cidr_range = "10.128.0.0/9"
  name          = "practice-subnet2"
  network       = google_compute_network.practice_vpc.name
}


resource "google_compute_subnetwork" "practice_subnet2" {
  ip_cidr_range = "10.128.0.0/9"
  name          = "practice-subnet2"
  network       = google_compute_network.practice_vpc.name
}




