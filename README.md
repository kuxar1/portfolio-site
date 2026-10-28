# portfolio-site

Source of [devopsing.dev](https://devopsing.dev): a Hugo site on a private S3 bucket behind CloudFront, provisioned with Terraform and deployed by GitHub Actions. Case study: [devopsing.dev/projects/devopsing-dev](https://devopsing.dev/projects/devopsing-dev/).

## Layout

```
content/, layouts/, assets/   Hugo site
infra/                        Terraform: S3, CloudFront, ACM (us-east-1), Cloudflare DNS
.github/workflows/
  terraform.yml               PR checks: Hugo build + terraform plan (posted as a PR comment)
  deploy.yml                  push to main: Hugo build → terraform apply → s3 sync → invalidation
```

## Prerequisites

- [aws-account-baseline](https://github.com/kuxar1/aws-account-baseline) applied: state bucket, OIDC provider, `plan` / `apply` roles.
- GitHub repository: variables `AWS_PLAN_ROLE_ARN`, `AWS_REGION`, secret `CLOUDFLARE_API_TOKEN` (DNS read).
- GitHub environment `production` (branch `main` only): variable `AWS_APPLY_ROLE_ARN`, secret `CLOUDFLARE_API_TOKEN` (DNS edit).

## Local

```bash
hugo server -D                                # preview at http://localhost:1313, drafts included
hugo new content projects/<slug>/index.md     # new project page from archetypes/projects.md
```

Run Hugo from the repository root. A project's architecture diagram is `diagram.svg` next to its `index.md`; until it exists, the page shows a placeholder.
