variable "iam_group_map" {
  default = [
    {
      group_name = "Developers"
      group_policies = [
        "arn:aws:iam::aws:policy/AWSCloud9Administrator",
        "arn:aws:iam::aws:policy/AWSProtonDeveloperAccess",
        "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
      ]
    },
    {
      group_name = "SysOps"
      group_policies = [
        "arn:aws:iam::aws:policy/job-function/SystemAdministrator",
        "arn:aws:iam::aws:policy/AWSCloud9Administrator",
        "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
      ]
    },
    {
      group_name     = "Administrators"
      group_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  ]
}
