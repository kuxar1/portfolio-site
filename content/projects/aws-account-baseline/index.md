---
title: "AWS Account Baseline"
summary: "Shared account layer: Terraform state backend, GitHub OIDC provider and least-privilege CI roles for every project."
status: live   # live | down | wip
stack: [IAM, OIDC, S3, Terraform, IAM Access Analyzer]
ci: "Applied by an admin, so project pipelines can't change their own permissions"
repo: "https://github.com/kuxar1/aws-account-baseline"
cost: "≈ $0/month"
weight: 2
---

The layer every project stands on. It changes rarely, has its own state, and owns everything that exists once per account.

## What it provides

- **State backend**: one S3 bucket with a key per project, native lock files (`use_lockfile`), versioning with lifecycle cleanup, no public access, `prevent_destroy`.
- **GitHub OIDC provider**, shared by all repositories.
- **CI roles per project**: a `plan` role for pull requests and an `apply` role for the `production` environment, plus a shared managed policy for state access.

## Key decisions

- **Separate layer, separate state**: a smaller blast radius, and project pipelines can't grant themselves permissions.
- **Least privilege for state**: a role reads and writes only its own key and lock file; nothing in CI can delete state.
- **Projects find shared resources by name** with data sources instead of `terraform_remote_state`, so no project needs access to another one's state.

## Problems I hit

- **Bootstrapping**: the state bucket is created with local state, then the layer migrates its own state into it (`terraform init -migrate-state`).
- **S3 Object Lock is not Terraform state locking**: Object Lock was removed before the bucket was created; locking comes from `use_lockfile`.
- **Broken policies that `plan` doesn't catch** (invalid ARNs, nonexistent actions) are now validated with IAM Access Analyzer before `apply`.

## What's next

- Access Analyzer for external access and a CloudTrail trail.
- Import the manually created AWS Budget into Terraform.
- CI for this repository with automated policy checks.
