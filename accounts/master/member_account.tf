resource "aws_organizations_account" "test" {
  name  = "test"
  email = "gosukenator+test@gmail.com"
}

output "id" {
  value = aws_organizations_account.test.id
}

data "aws_iam_policy_document" "switch_role_to_test_account" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    resources = [
      "arn:aws:iam::${aws_organizations_account.test.id}:role/OrganizationAccountAccessRole",
    ]
  }
}

resource "aws_iam_group" "test" {
  name = "test"
  path = "/"
}

resource "aws_iam_group_policy" "switch_role_to_test_account" {
  name   = "switch-role-to-test-account"
  group  = aws_iam_group.test.id
  policy = data.aws_iam_policy_document.switch_role_to_test_account.json
}

resource "aws_iam_group_membership" "test" {
  name  = "test-group-membership"
  users = ["mizzy"]
  group = aws_iam_group.test.name
}
