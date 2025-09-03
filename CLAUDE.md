# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

**Setup & Server:**
- `rvm use ruby-3.3.0` - Switch to correct Ruby version (required)
- `bundle install` - Install Ruby dependencies
- `bundle exec rake db:setup` - Create database and load schema/seeds
- `rails server` - Start development server
- `rails console` - Interactive Rails console

**Testing:**
- `bundle exec rake test` - Run test suite
- `bundle exec rake test:system` - Run system tests only
- `bundle exec rake test TEST=test/path/to/specific_test.rb` - Run single test file

**Database:**
- `bundle exec rake db:migrate` - Run migrations
- `bundle exec rake db:reset` - Drop, recreate, and seed database

## Architecture Overview

**FlowNote v2** is a Rails 8 markdown note-taking application with automatic tag extraction and public sharing capabilities.

### Core Models & Relationships

- **User**: Devise authentication with custom username generation. Has many notes, tags, folders
- **Note**: Central model with automatic slug/sharable_key generation, markdown rendering, and public/private sharing. Belongs to user, has many tags, has one history
- **Tag**: Auto-extracted from note content using hashtag pattern `(?:^|\s)(?:#)([\w\-\d]+)`. Belongs to note and user
- **Folder**: File organization with Active Storage attachments. Belongs to user
- **History**: Tracks note content changes with visual diffs using Diffy gem

### Key Features & Patterns

**Markdown Processing:**
- Custom Redcarpet renderer in `app/models/custom_markdown.rb`
- Supports checkboxes, mermaid diagrams, auto-linking tags, image sizing
- Tags automatically extracted and linked within note content

**Note Management:**
- Automatic slug generation for SEO-friendly URLs
- Public sharing via `~username/n/slug` pattern
- Bulk export all user notes as markdown ZIP archive
- Version history with visual diffs

**Search & Navigation:**
- Tag-based filtering at `/notes/by_tag/tagname`
- Full-text search using pg_search gem
- Public note browsing for shared content

### Technology Stack

- Rails 8.0.2 with Ruby 3.3.0
- PostgreSQL database
- Stimulus/Turbo (Hotwire) for frontend interactions
- Devise for authentication
- Redcarpet for markdown processing
- Active Storage for file uploads
- pg_search for PostgreSQL full-text search
- Capybara/Selenium for system testing