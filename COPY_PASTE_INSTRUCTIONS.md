# Copy All Files Below

Complete demo Ruby project - copy and paste all files in this structure.

## File Structure

```
demo-ruby-app/
├── .github/
│   └── workflows/
│       └── tests.yml
├── lib/
│   └── demo_app.rb
├── spec/
│   └── spec_helper.rb
│   └── user_spec.rb
├── .gitignore
├── .ruby-version
├── Gemfile
├── Rakefile
├── LICENSE
├── README.md
└── DEMO_SETUP.md
```

## Instructions

1. Create a new directory: `mkdir demo-ruby-app && cd demo-ruby-app`
2. Create subdirectories:
   - `mkdir -p .github/workflows lib spec`
3. Copy each file below to its location
4. In the new directory:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/demo-ruby-app.git
   git push -u origin main
   ```

## Important Notes

✅ This repo intentionally uses OLDER gem versions (6.1.0, 4.8.0, etc.) to demonstrate the upgrade monitor

✅ All tests pass with current versions - they'll still pass after upgrades (mostly)

✅ The Gemfile includes gems with available updates:
- Rails 6.1.0 (latest: 7.1+)
- Devise 4.8.0 (latest: 4.9+)
- RSpec 3.10.0 (latest: 3.13+)
- Pundit 2.1.0 (latest: 2.3+)
- Dotenv 2.7.6 (latest: 3.0+)

## After Pushing to GitHub

Run the Ruby Upgrade Monitor against this repo:

```bash
cd /path/to/ruby-upgrade-monitor

echo "GITHUB_TOKEN=<your-token>" > .env.test
echo "SLACK_BOT_TOKEN=<your-slack-token>" >> .env.test
echo "ANTHROPIC_API_KEY=<your-anthropic-key>" >> .env.test
echo "GITHUB_REPO_OWNER=<your-github-username>" >> .env.test
echo "GITHUB_REPO_NAME=demo-ruby-app" >> .env.test
echo "AUTO_CREATE_PRS=false" >> .env.test
echo "GEMS_TO_MONITOR=rails,devise,rspec,pundit" >> .env.test

set -a; source .env.test; set +a
ruby bin/monitor.rb
```

Watch as it:
1. Detects gem updates
2. Analyzes breaking changes with Claude
3. Tests upgrades locally
4. Creates PRs with smart descriptions
5. Notifies Slack

Perfect for hackday demo! 🚀

