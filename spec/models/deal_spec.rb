require 'spec_helper'

describe Deal do
  let(:deal) { Factory.build :deal }
  subject { deal }

  its(:save) { should be_true }
  it { should respond_to :user }

  describe "Validations" do
    it "should require a price" do
      deal.price = nil
      deal.should_not be_valid
    end

    it "should require a descrition" do
      deal.description = nil
      deal.should_not be_valid
    end

    it "should require a link" do
      deal.link = nil
      deal.should_not be_valid
    end

    it "should require a type" do
      deal.type = nil
      deal.should_not be_valid
    end
  end
end
