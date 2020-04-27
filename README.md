# TerraformによるAWS Organizationアカウント管理サンプル

## このサンプルの目的

- AWS Organization AccountをTerraformで一括管理したい。
- アカウントの操作は、そのアカウント固有のassume_roleが設定されたaws providerで行う。
- この場合、aws providerをaliasによって識別する必要がある。
- が、aliasには変数が使えない。例えば `aws_organizations_account.example.id`といったアカウント固有の値をaliasに含めることができない。
- aliasが必要なのは、すべてのOrganizationアカウントを同時に扱おうとするから。
- アカウント毎にディレクトリわけて個別に扱うようにすれば、aliasは必要ないはず。

## ファイル/ディレクトリ構成

このサンプルのファイル、ディレクトリ構成は以下の通りです。

```
├── Rakefile
├── accounts
│   └── example
│       ├── account.tf
│       ├── backend.tf
│       └── iam.tf
├── module
│   └── iam.tf
└── organization
    ├── backend.tf
    └── organization.tf
```

ディレクトリをわけると、各ディレクトリ毎にterraformを実行しないといけなくて面倒なので、それを簡略するためのRakefileを置いています。以下が実行例です。

```
$ rake organization:plan
$ rake organization:apply
$ rake accounts:example:plan
$ rake accounts:example:apply
$ rake all:plan
$ rake all:apply
```

tfファイルの内容は、各ファイルを参照してください。

## このサンプルの懸念事項

- アカウント間にまたがる設定を行う場合は、remote stateを利用する必要がある。このような設定が多くなると管理が煩雑になりそう。
  - VPC PeeringやTransit Gatewayで問題になる？
