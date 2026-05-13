# COMPLETE DEMO PROJECT - COPY & PASTE ALL FILES

This is a complete, ready-to-use demo Ruby project.

**Instructions:**
1. Create a new directory: `mkdir demo-ruby-app && cd demo-ruby-app`
2. Create the directory structure (listed below)
3. Copy each file's content exactly as shown
4. Push to GitHub
5. Run the Ruby Upgrade Monitor against it

---

## FILE 1: README.md

```markdown
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

\`\`\`bash
bundle install
bundle exec rspec
\`\`\`

## Gems

The app intentionally uses older versions of popular gems:
- \`rails\` - Web framework
- \`devise\` - Authentication
- \`rspec\` - Testing framework
- \`pundit\` - Authorization library
- \`dotenv\` - Environment management

These are set to versions with available updates to demonstrate the upgrade monitor.

## Testing

\`\`\`bash
bundle exec rspec
\`\`\`

All tests should pass with the current gem versions.

## Structure

\`\`\`
.
├── lib/
│   └── demo_app.rb
├── spec/
│   ├── spec_helper.rb
│   └── user_spec.rb
├── Gemfile
├── .ruby-version
└── README.md
\`\`\`

## Demo Notes

This project is designed to be used with the Ruby Upgrade Monitor to showcase:

1. **Automatic Detection**: Monitor finds newer gem versions
2. **Smart Analysis**: Claude analyzes breaking changes in Rails, Devise, etc.
3. **Safe Testing**: Monitor runs tests with upgraded gems
4. **PR Creation**: Creates ready-to-merge or draft PRs based on results
5. **Slack Notifications**: Team gets notified of upgrades

Try running the upgrade monitor on this repo to see it in action!

\`\`\`bash
# From the ruby-upgrade-monitor directory:
GITHUB_REPO_OWNER=your-org GITHUB_REPO_NAME=demo-ruby-app ruby bin/monitor.rb
\`\`\`

## Current Gem Versions

\`\`\`
rails (6.1.0)        - Latest is 7.1+
devise (4.8.0)       - Latest is 4.9+
rspec (3.10.0)       - Latest is 3.13+
pundit (2.1.0)       - Latest is 2.3+
dotenv (2.7.6)       - Latest is 3.0+
\`\`\`

These older versions ensure there are actual upgrades to demo!
```

---

## FILE 2: Gemfile

Location: `./Gemfile`

```ruby
source "https://rubygems.org"

ruby "3.2.2"

# Web framework - intentionally older to show upgrades
gem "rails", "6.1.0"

# Authentication
gem "devise", "4.8.0"

# Authorization
gem "pundit", "2.1.0"

# Environment variables
gem "dotenv", "2.7.6"

# Testing
group :development, :test do
  gem "rspec-rails", "5.0.0"
  gem "rspec", "3.10.0"
end

group :development do
  gem "pry"
end
```

---

## FILE 3: .ruby-version

Location: `./.ruby-version`

```
3.2.2
```

---

## FILE 4: Rakefile

Location: `./Rakefile`

```ruby
require 'rspec/core/rake_task'

task default: :spec

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = "spec/**/*_spec.rb"
  task.verbose = true
end

desc "Display RSpec version"
task :version do
  puts RSpec::Version::STRING
end
```

---

## FILE 5: .gitignore

Location: `./.gitignore`

```
# Ruby
*.gem
*.rbc
Gemfile.lock
.bundle/
vendor/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Environment
.env
.env.local

# Test coverage
/coverage/
/.rspec_status

# Logs
*.log

# Temp files
/tmp/
```

---

## FILE 6: LICENSE

Location: `./LICENSE`

```
MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## FILE 7: lib/demo_app.rb

Location: `./lib/demo_app.rb`

```ruby
# Demo Ruby App - Main Module
module DemoApp
  VERSION = "1.0.0"

  # Simple user management
  class User
    attr_accessor :email, :password, :name

    def initialize(email:, password:, name: "")
      @email = email
      @password = password
      @name = name
      @created_at = Time.now
    end

    # Validate user email
    def valid?
      valid_email? && valid_password?
    end

    # Check if email is valid
    def valid_email?
      email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end

    # Check if password is strong enough
    def valid_password?
      password && password.length >= 8
    end

    # Authenticate user
    def authenticate(candidate_password)
      password == candidate_password ? self : false
    end

    # Get user info
    def to_h
      {
        email: email,
        name: name,
        created_at: @created_at
      }
    end
  end

  # Authorization helper using Pundit pattern
  class UserPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      user.present?
    end

    def show?
      user == record || user.admin?
    end

    def create?
      true
    end

    def update?
      user == record || user.admin?
    end

    def destroy?
      user.admin?
    end
  end
end
```

---

## FILE 8: spec/spec_helper.rb

Location: `./spec/spec_helper.rb`

```ruby
ENV['RAILS_ENV'] ||= 'test'

require 'rspec'
require_relative '../lib/demo_app'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
```

---

## FILE 9: spec/user_spec.rb

Location: `./spec/user_spec.rb`

```ruby
require 'spec_helper'

describe DemoApp::User do
  describe "initialization" do
    it "creates a user with email and password" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123")
      expect(user.email).to eq("test@example.com")
      expect(user.password).to eq("password123")
    end

    it "creates a user with name" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123", name: "Test User")
      expect(user.name).to eq("Test User")
    end
  end

  describe "#valid?" do
    it "is valid with valid email and password" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123")
      expect(user.valid?).to be true
    end

    it "is invalid with invalid email" do
      user = DemoApp::User.new(email: "invalid-email", password: "password123")
      expect(user.valid?).to be false
    end

    it "is invalid with short password" do
      user = DemoApp::User.new(email: "test@example.com", password: "short")
      expect(user.valid?).to be false
    end
  end

  describe "#valid_email?" do
    it "validates correct email formats" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123")
      expect(user.valid_email?).to be true
    end

    it "rejects invalid email formats" do
      user = DemoApp::User.new(email: "not-an-email", password: "password123")
      expect(user.valid_email?).to be false
    end

    it "validates emails with plus addressing" do
      user = DemoApp::User.new(email: "test+tag@example.com", password: "password123")
      expect(user.valid_email?).to be true
    end
  end

  describe "#validate_password?" do
    it "requires at least 8 characters" do
      short = DemoApp::User.new(email: "test@example.com", password: "short")
      expect(short.valid_password?).to be false

      long = DemoApp::User.new(email: "test@example.com", password: "longenough")
      expect(long.valid_password?).to be true
    end
  end

  describe "#authenticate" do
    it "returns user when password matches" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123")
      result = user.authenticate("password123")
      expect(result).to eq(user)
    end

    it "returns false when password doesn't match" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123")
      result = user.authenticate("wrongpassword")
      expect(result).to be false
    end
  end

  describe "#to_h" do
    it "returns user as hash" do
      user = DemoApp::User.new(email: "test@example.com", password: "password123", name: "Test")
      hash = user.to_h
      
      expect(hash[:email]).to eq("test@example.com")
      expect(hash[:name]).to eq("Test")
      expect(hash).to have_key(:created_at)
    end
  end
end

describe DemoApp::UserPolicy do
  let(:user) { DemoApp::User.new(email: "user@example.com", password: "password123") }
  let(:admin) { DemoApp::User.new(email: "admin@example.com", password: "password123") }

  describe "authorization checks" do
    it "allows users to check if they can index" do
      policy = DemoApp::UserPolicy.new(user, user)
      expect(policy.index?).to be true
    end

    it "allows users to create" do
      policy = DemoApp::UserPolicy.new(user, user)
      expect(policy.create?).to be true
    end

    it "allows user to update their own record" do
      policy = DemoApp::UserPolicy.new(user, user)
      expect(policy.update?).to be true
    end
  end
end
```

---

## FILE 10: .github/workflows/tests.yml

Location: `./.github/workflows/tests.yml`

```yaml
name: Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    
    - uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2.2
        bundler-cache: true
    
    - name: Run tests
      run: bundle exec rspec
```

---

## SETUP STEPS

1. **Create directory:**
   ```bash
   mkdir demo-ruby-app
   cd demo-ruby-app
   ```

2. **Create subdirectories:**
   ```bash
   mkdir -p .github/workflows lib spec
   ```

3. **Create all files** listed above in their locations

4. **Initialize git:**
   ```bash
   git init
   git config user.name "Your Name"
   git config user.email "your.email@example.com"
   ```

5. **Commit and push:**
   ```bash
   git add .
   git commit -m "Initial commit: Demo Ruby app for upgrade monitor"
   git remote add origin https://github.com/YOUR_USERNAME/demo-ruby-app.git
   git branch -M main
   git push -u origin main
   ```

6. **Test locally:**
   ```bash
   bundle install
   bundle exec rspec
   ```

---

## USING WITH RUBY UPGRADE MONITOR

Once pushed to GitHub:

```bash
cd /path/to/hack_day

# Create test env file
cat > .env.demo << EOF
GITHUB_TOKEN=your_github_token
SLACK_BOT_TOKEN=your_slack_token
ANTHROPIC_API_KEY=your_anthropic_key
GITHUB_REPO_OWNER=your_username
GITHUB_REPO_NAME=demo-ruby-app
SLACK_CHANNEL=#dependency-updates
GEMS_TO_MONITOR=rails,devise,rspec,pundit,dotenv
AUTO_CREATE_PRS=false
EOF

# Load and run
set -a; source .env.demo; set +a
ruby bin/monitor.rb
```

---

## DEMO FLOW

Perfect for showing how the Ruby Upgrade Monitor works:

1. **Finds Updates** - Detects rails 6.1.0 → 7.1.0, devise 4.8.0 → 4.9.0, etc.
2. **Analyzes Changes** - Claude determines breaking vs. non-breaking
3. **Tests Upgrades** - Runs test suite with new gem versions  
4. **Creates PRs** - Draft for breaking changes, ready for non-breaking
5. **Notifies Team** - Slack message with summary and link

That's it! You have a complete demo project ready to showcase. 🚀

