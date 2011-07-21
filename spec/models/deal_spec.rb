require 'spec_helper'

describe Deal do
  let(:deal) { Factory.build :deal }
  subject { deal }

  its(:save) { should be_true }
  it { should respond_to :user }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:category) }
    it { should allow_mass_assignment_of(:company) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:end_date) }
    it { should allow_mass_assignment_of(:kind) }
    it { should allow_mass_assignment_of(:link) }
    it { should allow_mass_assignment_of(:price) }
    it { should allow_mass_assignment_of(:title) }

    it { should_not allow_mass_assignment_of(:discount) }
  end

  describe "Validations" do
    it "should require a category" do
      deal.category = nil
      deal.should_not be_valid
    end

    it "should require a company" do
      deal.company = nil
      deal.should_not be_valid
    end

    it "should require a descrition" do
      deal.description = nil
      deal.should_not be_valid
    end

    it "shouldn't require a discount if it lacks a real price" do
      deal.real_price = nil
      deal.discount = 1
      deal.should_not be_valid
    end

    it "should require a kind" do
      deal.kind = nil
      deal.should_not be_valid
    end

    describe "#link" do
      it "should be required"do
        deal.link = nil
        deal.should_not be_valid
      end

      describe "should begin with http:// or https://" do
        it "http://www.dealwit.me" do
          deal.link = "http://www.dealwit.me"
          deal.should be_valid
        end

        it "https://www.dealwit.me should be valid" do
          deal.link = "https://www.dealwit.me"
          deal.should be_valid
        end

        it "www.dealwit.me should be invalid" do
          deal.link = "www.dealwit.me"
          deal.should have(1).error_on(:link)
        end
      end
    end

    it "should require a price" do
      deal.price = nil
      deal.should_not be_valid
    end

    describe "#real_price" do
      it "should not be required" do
        deal.real_price = nil
        deal.should be_valid
      end

      it "should be greater than price" do
        deal.real_price = 2
        deal.price = 1

        deal.should be_valid
      end

      it "shouldn't be equal to price" do
        deal.real_price = 1
        deal.price = 1

        deal.should_not be_valid
      end

      it "shouldn't be smaller than price" do
        deal.real_price = 1
        deal.price = 2

        deal.should_not be_valid
      end
    end

    it "should require a title" do
      deal.title = nil
      deal.should_not be_valid
    end
  end

  describe "#calculate_discount" do
    it "should be calculated before validation" do
      deal.should_receive(:calculate_discount)
      deal.valid?
    end

    it "should withdraw the price from the real price" do
      deal.real_price = 2
      deal.price = 1.5
      deal.calculate_discount

      deal.discount.should == 0.5
    end

    it "should not withdraw the price from the real price if there's no real price" do
      deal.real_price = nil
      deal.discount = nil
      deal.calculate_discount

      deal.discount.should == nil
    end
  end

  describe "KINDS" do
    it "should return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]" do
      Deal::KINDS.should =~ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    end

    specify "DRINK: should be equal 1" do
      Deal::KIND_DRINK.should == 1
    end

    specify "BEAUTY_AND_HEALTH: should be equal 2" do
      Deal::KIND_BEAUTY_AND_HEALTH.should == 2
    end

    specify "PHONE: should be equal 3" do
      Deal::KIND_PHONE.should == 3
    end

    specify "CD_AND_DVD: should be equal 4" do
      Deal::KIND_CD_AND_DVD.should == 4
    end

    specify "HOME_AND_APPLIANCE: should be equal 5" do
      Deal::KIND_HOME_AND_APPLIANCE.should == 5
    end

    specify "ELETRONICS: should be equal 6" do
      Deal::KIND_ELETRONICS.should == 6
    end

    specify "FITNESS: should be equal 7" do
      Deal::KIND_FITNESS.should == 7
    end

    specify "COMPUTER: should be equal 8" do
      Deal::KIND_COMPUTER.should == 8
    end

    specify "BOOK: should be equal 9" do
      Deal::KIND_BOOK.should == 9
    end

    specify "CLOTHES: should be equal 10" do
      Deal::KIND_CLOTHES.should == 10
    end

    specify "TRAVEL: should be equal 11" do
      Deal::KIND_TRAVEL.should == 11
    end
  end
end
