variable "account_id" {}

provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
  alias   = "member"

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/OrganizationAccountAccessRole"
    session_name = "member"
  }
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  password_reuse_prevention      = 5
  max_password_age               = 90
  hard_expiry                    = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}
