# terraform-test에서 사용
variable "project" { }

variable "credentials_file" { }

variable "region" {
    default = "us-central1"
}

variable "zone" {
    default = "us-central1-c"
}

# 영역 변수 : terraform-vpc에서 사용
variable "zone-vpc1" {
    default = "asia-northeast3-a"
}

variable "zone-vpc2" {
    default = "asia-northeast3-c"
}