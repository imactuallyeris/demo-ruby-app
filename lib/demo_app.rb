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

    # Check if user object is present (Rails-style)
    def present?
      true
    end

    # Check if user is admin
    def admin?
      false
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

