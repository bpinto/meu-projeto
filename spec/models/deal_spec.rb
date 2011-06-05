require 'spec_helper'

describe Deal do
  let(:deal) { Factory.build :deal }
  subject { deal }

  it { should be_valid }

  describe "Validations" do
    describe "Price" do
      it "should not be nullable" do
        deal.price = nil
        deal.should_not be_valid
      end 
    end
  end
end
