module "iam" {
  source     = "../../module"
  account_id = aws_organizations_account.example.id
}
