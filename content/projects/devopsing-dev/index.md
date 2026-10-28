---
title: "devopsing.dev"
summary: "This site: Hugo on a private S3 bucket behind CloudFront with a custom domain, provisioned by Terraform and shipped by GitHub Actions."
status: live   # live | down | wip
stack: [S3, CloudFront, CloudFront Functions, ACM, Cloudflare DNS, Terraform, GitHub Actions, Hugo]
ci: "GitHub Actions: plan on PR, apply + deploy on merge (OIDC)"
repo: "https://github.com/kuxar1/portfolio-site"
demo: "https://devopsing.dev"
cost: "< $0.10/month"
weight: 1
---

Cloudflare DNS → CloudFront (ACM certificate, TLS 1.2+, HTTP/3) → private S3 bucket via Origin Access Control. A CloudFront Function maps `/path/` to `/path/index.html`; missing pages return a custom 404.

## Key decisions

- **Private bucket + OAC** instead of S3 website hosting: HTTPS only, no public bucket. The bucket policy is pinned to this distribution with `AWS:SourceArn`.
- **OIDC, no access keys.** A read-only `plan` role for pull requests and an `apply` role only for the `production` environment on `main`. Neither role can touch IAM.
- **ACM in us-east-1** via a provider alias; DNS validation records are created in Cloudflare with `for_each`.
- **Split Cloudflare tokens**: DNS read for PRs, DNS edit only in `production`.

## CI/CD

- **Pull request**: Hugo build check and `terraform plan`, posted as a PR comment that is updated in place.
- **Merge to `main`**: Hugo build → `terraform apply` of the saved plan → `s3 sync` → CloudFront invalidation.
- `main` is protected: a PR with passing checks is required. Plan and apply share one concurrency group per state.

## Problems I hit

- **OIDC `AccessDenied`**: CloudTrail showed GitHub's new immutable `sub` format (`owner@id/repo@id`); the trust policy was updated to match.
- **A manual `s3 sync --delete` from the wrong folder wiped the site.** The pipeline now builds before it gets AWS credentials and refuses to deploy without `index.html`.
- **IAM details**: bucket vs object ARNs, actions that only accept `"*"` (`ListCachePolicies`), and policies adding up (`s3:*` silently allowed deleting state).

## What's next

- CloudFront flat-rate Free plan with WAF.
- Preview environments for pull requests.
