---
title: "Cloud Resume"
summary: "This website: a static site on S3 + CloudFront with a serverless visitor counter, provisioned by Terraform and deployed by GitHub Actions."
status: wip   # live | down | wip
stack: [S3, CloudFront, ACM, Lambda, API Gateway, DynamoDB, Terraform, GitHub Actions]
ci: "GitHub Actions (OIDC, plan on PR, apply on merge)"
repo: "https://github.com/your-user/portfolio-site"
cost: "≈ $0/month (CloudFront Free plan + always-free Lambda/DynamoDB)"
weight: 1
---

## Architecture

Cloudflare DNS → CloudFront → private S3 bucket (OAC). The visitor counter calls API Gateway → Lambda → DynamoDB.

## Key decisions

- **Terraform instead of SAM/CloudFormation**: matches what most job postings ask for.
- **OIDC instead of access keys**: the pipeline assumes an IAM role with short-lived credentials, so no secrets are stored in GitHub.
- **DNS stays in Cloudflare**: the domain is registered there; the AWS projects use a delegated `lab.` subdomain in Route 53.

## CI/CD pipeline

`fmt → validate → tflint → checkov → plan (PR comment) → apply (main) → hugo build → s3 sync → CloudFront invalidation`

## Lessons learned

_Coming soon._
