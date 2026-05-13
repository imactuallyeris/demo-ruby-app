# Demo Ruby App

A simple demo Ruby application for testing the Ruby Upgrade Monitor.

This project is intentionally using older gem versions so the Ruby Upgrade Monitor can demonstrate:
- Detecting available updates
- Analyzing breaking changes
- Running tests
- Creating PRs

## What This App Does

A simple user management library with basic validation and authentication helpers.

## Getting Started

```bash
bundle install
bundle exec rspec
```

## Gems

The app intentionally uses older versions of popular gems:
- `rails` - Web framework
- `devise` - Authentication
- `rspec` - Testing framework
- `pundit` - Authorization library
- `dotenv` - Environment management

These are set to versions with available updates to demonstrate the upgrade monitor.

## Testing

```bash
bundle exec rspec
```

All tests should pass with the current gem versions.

## Structure

```
.
├── lib/
│   ├── demo_app.rb
│   └── user.rb
├── spec/
│   ├── spec_helper.rb
│   ├── user_spec.rb
│   └── fixtures/
│       └── users_fixture.yml
├── Gemfile
├── .ruby-version
└── README.md
```

## Demo Notes

This project is designed to be used with the Ruby Upgrade Monitor to showcase:

1. **Automatic Detection**: Monitor finds newer gem versions
2. **Smart Analysis**: Claude analyzes breaking changes in Rails, Devise, etc.
3. **Safe Testing**: Monitor runs tests with upgraded gems
4. **PR Creation**: Creates ready-to-merge or draft PRs based on results
5. **Slack Notifications**: Team gets notified of upgrades

Try running the upgrade monitor on this repo to see it in action!

```bash
# From the ruby-upgrade-monitor directory:
GITHUB_REPO_OWNER=your-org GITHUB_REPO_NAME=demo-ruby-app ruby bin/monitor.rb
```

## Current Gem Versions

```
rails (6.1.0)        - Latest is 7.1+
devise (4.8.0)       - Latest is 4.9+
rspec (3.10.0)       - Latest is 3.13+
pundit (2.1.0)       - Latest is 2.3+
```

These older versions ensure there are actual upgrades to demo!

