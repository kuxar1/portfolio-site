# portfolio-site

Source of [devopsing.dev](https://devopsing.dev): Hugo static site, hosted on S3 + CloudFront.

```bash
hugo server                                   # local preview at http://localhost:1313
hugo new content projects/<slug>/index.md     # new project page from archetypes/projects.md
hugo --gc --minify                            # production build into public/
```

Project pages are drafts until `draft: true` is removed. Put the architecture diagram next to `index.md` as `diagram.svg`.
