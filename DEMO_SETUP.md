# Using This Demo Project

This is a demo Ruby project designed to showcase the Ruby Upgrade Monitor.

## Setup Instructions

### 1. Create a new GitHub repository

```bash
# Create on GitHub: https://github.com/new
# (Name it something like "demo-ruby-app")
```

### 2. Copy this project to your local machine

```bash
# Create a new directory
mkdir demo-ruby-app
cd demo-ruby-app

# Initialize git
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### 3. Copy all the files from this directory

Copy all files shown below into your new directory.

### 4. Push to GitHub

```bash
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/your-username/demo-ruby-app.git
git branch -M main
git push -u origin main
```

### 5. Test locally

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rspec
```

All tests should pass! ✅

## Running the Upgrade Monitor

Once you've pushed this to GitHub:

```bash
cd /path/to/ruby-upgrade-monitor
GITHUB_TOKEN=your_token \
SLACK_BOT_TOKEN=your_slack_token \
ANTHROPIC_API_KEY=your_anthropic_key \
AUTO_CREATE_PRS=false \
GITHUB_REPO_OWNER=your-username \
GITHUB_REPO_NAME=demo-ruby-app \
GEMS_TO_MONITOR=rails,devise,rspec,pundit \
ruby bin/monitor.rb
```

## What Will Happen

The upgrade monitor will:

1. ✅ **Detect Updates**
   - Find newer versions of: rails, devise, rspec, pundit, dotenv
   - Show available upgrades like rails 6.1.0 → 7.1.0

2. ✅ **Analyze Changes**
   - Use Claude to analyze what changed
   - Identify breaking changes vs. non-breaking
   - Generate migration guides for breaking changes

3. ✅ **Test Upgrades**
   - Clone this repo locally
   - Run `bundle update gem_name`
   - Execute `bundle exec rspec` to verify tests pass

4. ✅ **Create PRs**
   - **Non-breaking + Tests Pass** → Ready PR
   - **Breaking Changes** → Draft PR with migration guide
   - **Tests Fail** → Draft PR with failures listed

5. ✅ **Notify Slack**
   - Posts formatted message to your Slack channel
   - Shows status, version change, action button

## Demo Flow

Perfect for showing:

1. **Start Monitor**
   ```
   "Let me monitor this demo project for gem updates..."
   ```

2. **Monitor Detects Upgrades**
   ```
   "Found Rails 6.1.0 → 7.1.0, Devise 4.8.0 → 4.9.0, RSpec 3.10.0 → 3.13.2..."
   ```

3. **Claude Analyzes Changes**
   ```
   "Analyzing changelogs with Claude AI to detect breaking changes..."
   ```

4. **Tests Are Run**
   ```
   "Testing upgrade locally... all tests pass! ✓"
   ```

5. **PRs Are Created**
   ```
   "Created PR for rails 7.1.0 - draft due to breaking changes"
   "Created PR for rspec 3.13.2 - ready to merge, all tests pass"
   ```

6. **Team Notified**
   ```
   "Slack notifications posted to #dependency-updates"
   ```

## Key Points to Highlight in Demo

- 🤖 **Claude AI** - Analyzes real changelogs, not just regex
- 🧪 **Automatic Testing** - Verify upgrades don't break code
- 📊 **Smart PRs** - Ready PRs vs. draft PRs based on test results
- 💬 **Slack Integration** - Team stays informed
- 🔄 **Full Automation** - No manual work needed
- 🎯 **Production Ready** - Comprehensive error handling, logging, etc.

## Troubleshooting

**Tests failing to run?**
```bash
bundle install
bundle exec rspec --version
```

**Gems won't install?**
Make sure you're using Ruby 3.2.2:
```bash
rbenv local 3.2.2
ruby --version
```

**Want to try with different gem versions?**
Edit `Gemfile` to use different versions, commit, and the monitor will detect the changes.

## Next Steps

1. Push to GitHub
2. Get GitHub/Slack/Anthropic credentials
3. Run the upgrade monitor against this repo
4. Watch the magic happen! ✨

