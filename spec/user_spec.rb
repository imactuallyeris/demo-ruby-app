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

