---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
summary: "One sentence: what it is and which problem it solves."
status: wip   # live | down | wip
stack: []
ci: ""
repo: ""
demo: ""
post: ""
cost: ""
weight: 10
draft: true
---

## Architecture

![Architecture](diagram.svg)

## Key decisions

- **Decision** — why, and what was traded off.

## CI/CD pipeline

`lint → test → plan → apply`

## Lessons learned
