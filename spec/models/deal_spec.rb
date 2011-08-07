require 'spec_helper'

describe Deal do
  let(:deal) { Factory.build :deal }
  subject { deal }

  its(:save) { should be_true }
  it { should respond_to :user }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:address) }
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
        it "http://www.dealwit.me should be valid" do
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

  describe "CATEGORIES" do
    it "should return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]" do
      Deal::CATEGORIES.should =~ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    end

    specify "DRINK: should be equal 1" do
      Deal::CATEGORY_DRINK.should == 1
    end

    specify "BEAUTY_AND_HEALTH: should be equal 2" do
      Deal::CATEGORY_BEAUTY_AND_HEALTH.should == 2
    end

    specify "PHONE: should be equal 3" do
      Deal::CATEGORY_PHONE_AND_CAMERA.should == 3
    end

    specify "CD_AND_DVD: should be equal 4" do
      Deal::CATEGORY_CD_AND_DVD.should == 4
    end

    specify "HOME_AND_APPLIANCE: should be equal 5" do
      Deal::CATEGORY_HOME_AND_APPLIANCE.should == 5
    end

    specify "ELETRONICS: should be equal 6" do
      Deal::CATEGORY_ELETRONICS.should == 6
    end

    specify "FITNESS: should be equal 7" do
      Deal::CATEGORY_FITNESS.should == 7
    end

    specify "COMPUTER: should be equal 8" do
      Deal::CATEGORY_COMPUTER.should == 8
    end

    specify "BOOK: should be equal 9" do
      Deal::CATEGORY_BOOK.should == 9
    end

    specify "CLOTHES: should be equal 10" do
      Deal::CATEGORY_CLOTHES.should == 10
    end

    specify "TRAVEL: should be equal 11" do
      Deal::CATEGORY_TRAVEL.should == 11
    end

    specify "RESTAURANT: should be equal 12" do
      Deal::CATEGORY_RESTAURANT.should == 12
    end

    specify "TOY: should be equal 13" do
      Deal::CATEGORY_TOY.should == 13
    end

    specify "CAR: should be equal 14" do
      Deal::CATEGORY_CAR.should == 14
    end
  end

  describe "KINDS" do
    it "should return [1, 2, 3]" do
      Deal::KINDS.should =~ [1, 2, 3]
    end

    specify "OFFER: should be equal 1" do
      Deal::KIND_OFFER.should == 1
    end

    specify "DAILY_DEAL: should be equal 2" do
      Deal::KIND_DAILY_DEAL.should == 2
    end

    specify "ON_SALE: should be equal 3" do
      Deal::KIND_ON_SALE.should == 3
    end
  end

  describe "#calculate_discount" do
    it "should be calculated on validation" do
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

  describe "#discount_to_percentage" do
    it "should return nil when there's no discount" do
      deal.discount = nil
      deal.discount_to_percentage.should == nil
    end

    it "should return 30 when there's a 30% discount" do
      deal.real_price = 7.4
      deal.discount = 2.22

      deal.discount_to_percentage.should == 30
    end

    it "should return 50 when there's a 50% discount" do
      deal.real_price = 3.6
      deal.discount = 1.8

      deal.discount_to_percentage.should == 50
    end

    it "should return 100 when there's a 100% discount" do
      deal.real_price = 1
      deal.discount = 1

      deal.discount_to_percentage.should == 100
    end
  end
end