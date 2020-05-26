resource "aws_organizations_account" "example" {
  name      = "example"
  email     = "foo@example.com"
  role_name = "OrganizationAccountAccessRole"
}
