require 'spec_helper'
require "cancan/matchers"

describe Ability do
  let(:user) { Factory.create :user }

  let(:guest_ability) { Ability.new(User.new) }
  let(:user_ability) { Ability.new(user) }

  describe "deal" do
    describe "guests" do
      it "should be able to read all deals" do
        guest_ability.should be_able_to(:read, Deal)
      end

      it "should not be able to manage any deal" do
        guest_ability.should_not be_able_to(:manage, Deal)
      end
    end

    describe "users" do
      it "should be able to read all deals" do
        user_ability.should be_able_to(:read, Deal)
      end

      it "should be able to create deals" do
        user_ability.should be_able_to(:create, Deal)
      end

      it "should be able to manage theirs deals" do
        own_deal = Factory.create :deal, :user => user
        user_ability.should be_able_to(:manage, own_deal)
      end

      it "should not be able to manage other user's deals" do
        others_deal = Factory.create :deal
        user_ability.should_not be_able_to(:manage, others_deal)
      end
    end
  end
end
