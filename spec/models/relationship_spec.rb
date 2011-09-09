require 'spec_helper'

describe Relationship do
  let(:relationship) { Factory.build :relationship }
  subject { relationship }

  its(:save) { should be_true }

  it { should respond_to :follower }
  it { should respond_to :followed }

  describe "Validations" do
    it "one should not be able to have a relationship with oneself" do
      relationship.followed = relationship.follower
      relationship.should_not be_valid
    end

    it "one should have only one relationship with another at most do" do
      same_relationship = FactoryGirl.create :relationship

      relationship.follower = same_relationship.follower
      relationship.followed = same_relationship.followed
      relationship.should_not be_valid
    end

    describe "#follower_id" do
      it "should not be blank" do
        relationship.follower = nil
        relationship.should_not be_valid
      end
    end

    describe "#followed_id" do
      it "should not be blank" do
        relationship.followed = nil
        relationship.should_not be_valid
      end
    end
  end
end
