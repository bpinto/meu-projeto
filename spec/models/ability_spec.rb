require 'spec_helper'
require "cancan/matchers"

describe Ability do
  shared_examples_for "All Users" do
    it "should be able to see todays' deals" do
      ability.should be_able_to(:today, Deal)
    end

    it "should be able to see other user's page" do
      ability.should be_able_to(:read, User)
    end
  end

  describe "deal" do
    describe "guests" do
      let(:ability) { Ability.new(User.new) }

      it_should_behave_like "All Users"

      it "should be able to read all deals" do
        ability.should be_able_to(:read, Deal)
      end

      it "should not be able to manage any deal" do
        ability.should_not be_able_to(:manage, Deal)
      end
    end

    describe "users" do
      let(:user) { FactoryGirl.create :user }
      let(:ability) { Ability.new(user) }

      it_should_behave_like "All Users"

      it "should be able to read all deals" do
        ability.should be_able_to(:read, Deal)
      end

      it "should be able to create deals" do
        ability.should be_able_to(:create, Deal)
      end

      it "should be able to manage theirs deals" do
        own_deal = FactoryGirl.create :deal, :user => user
        ability.should be_able_to(:manage, own_deal)
      end

      it "should not be able to manage other user's deals" do
        others_deal = FactoryGirl.create :deal
        ability.should_not be_able_to(:manage, others_deal)
      end

      it "should be able to see todays' deals" do
        ability.should be_able_to(:today, Deal)
      end

      it "should be able to follow another user" do
        ability.should be_able_to(:follow, User)
      end

      it "should be able to unfollow another user" do
        ability.should be_able_to(:unfollow, User)
      end
    end
  end
end
