require 'spec_helper'

describe User do
  let(:user) { Factory.build :user }
  subject { user }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :deals }
  it { should respond_to :relationships }
  it { should respond_to :followers }
  it { should respond_to :following }
  it { should respond_to :reverse_relationships }
  it { should respond_to :login }
  it { should respond_to :login= }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:remember_me) }
    it { should allow_mass_assignment_of(:username) }
  end

  describe "email" do
    it "should be required" do
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
      email = "upcase@test.com"
      Factory.create :user, :email => email
      user.email = email.upcase
      user.should_not be_valid
    end
  end

  describe "username" do
    it "should be required" do
      user.username = ""
      user.should_not be_valid
    end

    it "should be unique" do
      duplicated_username = Factory.create(:user).username
      user.username = duplicated_username
      user.should_not be_valid
    end

    it "should be case-insensitive" do
      username = "upcase_test"
      Factory.create :user, :username => username
      user.username = username.upcase
      user.should_not be_valid
    end

    it "should not have less than 5 characters" do
      user.username = "a" * 4
      user.should_not be_valid
    end

    it "should not have more than 20 characters" do
      user.username = "a" * 21
      user.should_not be_valid
    end

    it "should allow underscores" do
      user.username = "with_underscore"
      user.should be_valid
    end
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

  describe "relationships" do
    let(:user) { Factory.create :confirmed_user }
    let(:another_user) { Factory.create :confirmed_user }

    it "shouldn't be able to follow himself" do
      lambda { user.follow! user }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should create a new relationship when a user follow another" do
      user.follow! another_user
      user.reload
      user.following.length.should == 1
    end

    it "should destroy the relationship when a user unfollow another" do
      user.follow! another_user
      user.unfollow! another_user
      user.following.length.should == 0
    end

    context "no user followed" do
      before(:each) do
        user.following.size.should == 0
      end

      it "should be able to follow another user" do
        user.follow! another_user
      end
    end

    context "one user followed" do
      before(:each) do
        @followed_user = Factory.create :confirmed_user
        user.follow! @followed_user

        user.following.size.should == 1
      end

      it "should follow that user" do
        (user.follow? @followed_user).should == true
      end

      it "should be able to follow one more user" do
        user.follow! another_user
      end

      it "should be able to stop following the followed user" do
        user.unfollow! @followed_user
      end
    end

    context "two users followed" do
      before(:each) do
        @first_followed_user = Factory.create :confirmed_user
        @second_followed_user = Factory.create :confirmed_user
        user.follow! @first_followed_user
        user.follow! @second_followed_user

        user.following.size.should == 2
      end

      it "should follow both users" do
        (user.follow? @first_followed_user).should == true
        (user.follow? @second_followed_user).should == true
      end

      it "should be able to follow one more user" do
        user.follow! another_user
      end

      it "shouldn't stop following all other users once a user stops following one" do
        user.unfollow! @first_followed_user

        user.following.first.should == @second_followed_user
      end
    end
  end
end
