---
name: publish
description: Create content for the Ruby Taiwan Jekyll website — blog posts, events, and community campaigns. Use this skill whenever the user wants to publish a post, announce an event, add a campaign, or mentions creating content for the Ruby Taiwan site. Trigger on phrases like "/publish post", "/publish event", "/publish campaign", or any variation of "add a post/event to the site". Make sure to use this skill even for brief commands like "/publish event RubyConf" or "/publish post announcement".
---

# Publish Content for Ruby Taiwan Website

You are helping the user create content for the Ruby Taiwan community website, a Jekyll static site. All generated content must be in Traditional Chinese (Taiwan / zh-TW).

## Usage

```
/publish <type> [description]
```

- `type`: One of `post`, `event`, or `campaign`
- `description`: Optional free-text context about what to publish

If the user omits the type, ask which content type they want to create.

## Content Types

### post — Blog Post

File: `_posts/YYYY-MM-DD-slug.md` (slug in lowercase English, hyphen-separated)

Front matter:
```yaml
---
title: "文章標題"
date: 'YYYY-MM-DD'
layout: post
---
```

Required fields to collect:
| Field | Prompt | Default |
|-------|--------|---------|
| title | 文章標題是什麼？ | — |
| date  | 發文日期？ | today |
| body  | 文章內容或素材？ | — |

Content style guidelines:
- Friendly, casual community tone — like sharing news with friends
- Use brackets for event names in titles: `【RubyConf Taiwan】...`
- Include relevant links (official site, registration, social media)
- Image format: `![alt]({{ '/assets/images/posts/filename' | relative_url }})`
- End with a call to follow community platforms (Facebook, Instagram) when appropriate

### event — Event

File: `_events/YYYY-MM-DD-slug.md`

Front matter:
```yaml
---
title: 活動名稱
date: YYYY-MM-DD
location: "活動地點"
time: "HH:MM - HH:MM"
ended: false
need_apply: false
event_url: https://registration-link
---
```

Required fields to collect:
| Field | Prompt | Default |
|-------|--------|---------|
| title | 活動名稱？ | — |
| date  | 活動日期？ | — |
| location | 活動地點（地址或場地名稱）？ | — |
| time | 活動時間（起迄）？ | — |
| need_apply | 是否需要報名？ | false |
| event_url | 報名或活動連結？ | — |

Notes:
- `ended` is always `false` for new events
- Body content after front matter is optional, usually left empty
- Time uses 24-hour format: `HH:MM - HH:MM`

### campaign — Community Campaign

File: `_data/campaigns.yml` (append to existing array)

Data format:
```yaml
- title: "活動名稱"
  id: "lowercase-identifier"
  photo:
    - "image1.jpg"
  desc: >
    活動介紹
  links:
    - name: "連結名稱"
      url: "https://url"
```

Required fields to collect:
| Field | Prompt | Default |
|-------|--------|---------|
| title | 社群活動名稱？ | — |
| id    | 識別碼（英文小寫）？ | derived from title |
| desc  | 簡短介紹？ | — |
| links | 相關連結（名稱 + 網址）？ | — |
| photo | 圖片檔名？ | — |

## Workflow

1. **Parse arguments** — extract the content type and any information already provided in the description.
2. **Collect missing fields** — for each required field not yet known, ask the user one question at a time in Traditional Chinese. If the user provided enough context in the description, skip those fields.
3. **Generate file** — once all required fields are collected, create the file directly.
4. **Confirm** — tell the user the file path and remind them to preview with `bundle exec jekyll serve`.

If the user provides all necessary information upfront, skip the interview and create the file immediately. The goal is to minimize back-and-forth.

## Edge Cases

- User provides event-like info (location, time) without specifying type → default to `event`
- User wants both an event and a blog post announcing it → create both files, event first then post
- Date not provided for a post → default to today
- Date not provided for an event → must ask, never assume
