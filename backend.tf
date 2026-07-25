terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    bucket = "aaa-storage"
    region = "ru-central1"
    key    = "global/terraform.tfstate" # путь к файлу состояния внутри бакета

#    access_key = ""
#    secret_key = ""

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}