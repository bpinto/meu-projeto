require 'spec_helper'

describe Deal do
  let(:deal) { Factory.build :deal }
  subject { deal }

  its(:save) { should be_true }
  it { should respond_to :user }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:link) }
    it { should allow_mass_assignment_of(:price) }
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:kind) }
  end

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

    it "should require a kind" do
      deal.kind = nil
      deal.should_not be_valid
    end
  end

  describe "#links" do
    describe "should begin with http:// or https://" do
      it "http://www.dealwit.me" do
        deal.link = "http://www.dealwit.me"
        deal.should be_valid
      end

      it "https://www.dealwit.me" do
        deal.link = "https://www.dealwit.me"
        deal.should be_valid
      end

      it "www.dealwit.me" do
        deal.link = "www.dealwit.me"
        deal.should have(1).error_on(:link)
      end
    end
  end
end
