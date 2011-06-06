require 'spec_helper'

describe User do
  let(:user) { Factory.build :user }
  subject { user }

  its(:save) { should be_true }
  it { should respond_to :deals }
  it { should respond_to :relationships }
  it { should respond_to :followers }

  it "should require an email address" do
    user.email = ""
    user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      user.email = address
      user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      user.email = address
      user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    duplicated_email = Factory.create(:user).email
    user.email = duplicated_email
    user.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = user.email.upcase
    Factory.create :user, :email => upcased_email
    user.email = upcased_email
    user.should_not be_valid
  end

  describe "passwords" do
    it "should have a password attribute" do
      user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      user.password = ""
      user.password_confirmation = ""
      user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      user.password_confirmation = "invalid"
      user.should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      user.password = short
      user.password_confirmation = short
      user.should_not be_valid
    end
  end

  describe "password encryption" do
    it "should have an encrypted password attribute" do
      user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      user.encrypted_password.should_not be_blank
    end
  end
end
