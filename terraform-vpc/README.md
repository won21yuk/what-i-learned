# Terraform practice - GCP의 VPC, Subnet 생성

# 계획
- VPC 1개 생성
  - region은 asia-northeast3-a
  - cidr은 내부 인스턴스간 허용 가능하도록 10.128.0.0/9로 설정
  
- Subnet 2개 생성
  - 앞서 생성한 VPC 참조하여 생성
  - cidr 10.128.0.0/9로 설정
