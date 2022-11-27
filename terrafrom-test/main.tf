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
  credentials = file("terraform-practice-369907-098e7b100728.json")

  # 자신의 프로젝트 아이디 입력
  project = "terraform-practice-369907"
  region  = "asia-northeast3"
  zone    = "asia-northeast3-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}