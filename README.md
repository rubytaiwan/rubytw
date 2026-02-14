# Ruby Taiwan

The official website of the [Ruby Taiwan](https://ruby.tw) community, built with [Jekyll](https://jekyllrb.com/) static site generator. The site serves as a central hub for Taiwan's Ruby community, featuring events, blog posts, community campaigns, and related resources.

## Getting Started

### Prerequisites

- Ruby (see `.ruby-version`)
- Bundler

### Installation

```bash
bundle install
```

### Development

```bash
bundle exec jekyll serve    # Start dev server at http://localhost:4000
bundle exec jekyll build    # Build static site to _site/
```

### Linting

```bash
bundle exec rubocop         # Ruby code style check
```

## Project Structure

```
├── _data/          # YAML data files (campaigns, communities, i18n, social media)
├── _events/        # Event collection (Markdown with front matter)
├── _includes/      # Reusable Liquid template partials
├── _layouts/       # Page templates (default, landing, post)
├── _posts/         # Blog posts (date-based naming convention)
├── _sass/          # SASS stylesheets (indented .sass syntax)
│   ├── base/       # Mixins and style guide
│   └── style/      # Per-section styles
└── assets/         # Static assets (CSS, JS, images)
```

## Tech Stack

- **Static Site Generator**: Jekyll
- **CSS Framework**: Bootstrap 3.4.1
- **JavaScript**: jQuery 3.7.1 (with Easing and TouchSwipe plugins)
- **Icons**: Font Awesome 4.7.0
- **Fonts**: Google Fonts (Montserrat, Lobster)
- **Stylesheets**: SASS (indented syntax)
- **Deployment**: GitHub Pages via GitHub Actions

## Contributing

### Adding Events

Create a new file `YYYY-MM-DD-slug.md` in `_events/` with the following front matter:

```yaml
---
title: "Event Title"
date: YYYY-MM-DD
location: "Venue Name"
time: "HH:MM"
event_url: "https://..."
---
```

Mark ended events by adding `ended: true` to the front matter.

### Adding Blog Posts

Create a new file `YYYY-MM-DD-slug.md` in `_posts/` with the following front matter:

```yaml
---
title: "Post Title"
cover: "optional-cover-image-url"
---
```

### Adding Community Campaigns

Edit `_data/campaigns.yml` to add new campaign entries.

### Translations

UI strings are managed in `_data/i18n.yml`.

## License

This project is maintained by the Ruby Taiwan community.
