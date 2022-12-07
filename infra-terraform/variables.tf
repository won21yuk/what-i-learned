# 프로젝트 ID 변수
variable "project" { }

# 권한 파일 경로 변수
variable "credentials_file" { }

# 리전 변수
variable "region" {
    default = "asia-northeast3"
}

# 영역 변수
variable "zone" {
    default = "asia-northeast3-a"
}