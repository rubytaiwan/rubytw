# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ruby Taiwan community official website, built with Jekyll static site generator. Migrated from a Rails frontend to a Jekyll theme. Site content is in Traditional Chinese (zh-TW).

## Commands

```bash
bundle install                  # Install dependencies
bundle exec jekyll serve        # Start dev server (localhost:4000)
bundle exec jekyll build        # Build static site to _site/
bundle exec rubocop             # Ruby code style check
```

## Architecture

Jekyll static site with data-driven architecture:

- **`_data/`** — YAML data files (campaigns, communities, i18n, social_media), the primary content source
- **`_events/`** — Event collection files (Markdown with front matter), sorted by date
- **`_layouts/`** — Page templates: `default.html` (base HTML), `landing.html` (homepage), `post.html` (blog post)
- **`_includes/`** — Reusable Liquid template partials (nav, cover, blogs, events, campaigns, communities, subscription)
- **`_posts/`** — Markdown/HTML blog posts using date-based naming convention
- **`_sass/`** — SASS stylesheets split into `base/` (mixin, styleguide) and `style/` (per-section styles), entry point is `style.sass`
- **`assets/`** — Static assets: CSS (`main.sass` compile entry), JS (jQuery interactions), images

## Frontend Stack

- Bootstrap 3.4.1, jQuery 3.7.1 (with Easing and TouchSwipe)
- Font Awesome 4.7.0, Google Fonts (Montserrat, Lobster)
- SASS uses indented syntax (`.sass`, not `.scss`)

## Content Conventions

- Add events: create `YYYY-MM-DD-slug.md` in `_events/`, front matter requires `title`, `date`, `location`, `time`, `event_url`; mark ended events with `ended: true`
- Add community campaigns: edit `_data/campaigns.yml`
- Add blog posts: create `YYYY-MM-DD-slug.md` in `_posts/`, front matter requires `title` and optional `cover`
- UI translations: `_data/i18n.yml`
