terraform {
  required_version = "~> 0.12"

  backend "s3" {
    region         = "ap-northeast-1"
    dynamodb_table = "tf.example.com"
    bucket         = "tf.example.com"
    key            = "organization"
    session_name   = "organization"
    encrypt        = true
  }
}
