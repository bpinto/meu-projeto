require 'spec_helper'

describe Relationship do
  let(:relationship) { Factory.build :relationship }
  subject { relationship }

  its(:save) { should be_true }

  it { should respond_to :follower }
  it { should respond_to :followed }

  describe "Validations" do
    describe "#follower_id" do
      it "should not be blank" do
        relationship.follower = nil
        relationship.should_not be_valid
      end

      it "should not be equal to #followed_id" do
        relationship.followed = relationship.follower
        relationship.should_not be_valid
      end

      it "should have one relationship with another at most" do
        same_relationship = Factory.create :relationship

        relationship.follower = same_relationship.follower
        relationship.followed = same_relationship.followed
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
