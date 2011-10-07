#encoding: UTF-8
require 'spec_helper'

describe Deal do

  shared_examples_for "All Deals" do
    its(:save) { should be_true }
    its(:switched_on?) { should be_true }

    it { should respond_to :city }
    it { should respond_to :user }

    describe "Accessibility" do
      it { should allow_mass_assignment_of(:address) }
      it { should allow_mass_assignment_of(:category) }
      it { should allow_mass_assignment_of(:company) }
      it { should allow_mass_assignment_of(:description) }
      it { should allow_mass_assignment_of(:discount) }
      it { should allow_mass_assignment_of(:end_date) }
      it { should allow_mass_assignment_of(:kind) }
      it { should allow_mass_assignment_of(:link) }
      it { should allow_mass_assignment_of(:price) }
      it { should allow_mass_assignment_of(:real_price) }
      it { should allow_mass_assignment_of(:title) }
    end

    describe "Validations" do
      it "should require a category" do
        deal.category = nil
        deal.should_not be_valid
      end

      it "should require a user" do
        deal.user = nil
        deal.should_not be_valid
      end

      it "should require a city" do
        deal.city = nil
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

      describe "#end_date" do
        it "should not be before or equal to now" do
          deal.end_date = Time.now
          deal.should_not be_valid
        end

        it "should be after now" do
          deal.end_date = Time.now + 1
          deal.should be_valid
        end
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

      it "should require a title" do
        deal.title = nil
        deal.should_not be_valid
      end
    end
  end

  shared_examples_for "Not On Sale Deals" do

    describe "#real_price" do
      it "should be greater than price" do
        deal.real_price_mask = "2,00"
        deal.price = "1,00"
        deal.should be_valid
      end
      it "shouldn't be equal to price" do
        deal.real_price_mask = "1,00"
        deal.price_mask = "1,00"
        deal.should_not be_valid
      end
      it "shouldn't be smaller than price" do
        deal.real_price_mask = "1,00"
        deal.price_mask = "2,00"
        deal.should_not be_valid
      end
    end
  end

  describe "On Sale Deals" do
    let(:deal) { FactoryGirl.build :deal_on_sale }
    subject { deal }

    it_should_behave_like "All Deals"

    describe "Validations" do
      it "should require a discount" do
        deal.discount = nil
        deal.should_not be_valid
      end

      it "should not require a price" do
        deal.price_mask = nil
        deal.should be_valid
      end

      it "should not require a real price" do
        deal.real_price_mask = nil
        deal.should be_valid
      end
    end
  end

  describe "Deals Offer" do
    let(:deal) { FactoryGirl.build :deal_offer }
    subject { deal }

    it_should_behave_like "All Deals"
    it_should_behave_like "Not On Sale Deals"

    describe "Validations" do
      it "should require a price" do
        deal.price_mask = nil
        deal.should_not be_valid
      end

      it "should require a real price" do
        deal.real_price_mask = nil
        deal.should_not be_valid
      end
      describe "#calculate_discount" do
        it "should be calculated on validation" do
          deal.should_receive(:calculate_discount)
          deal.valid?
        end

        it "should calculate the percentage of discount" do
          deal.real_price = 2
          deal.price = 1.5
          deal.calculate_discount

          deal.discount.should == 25
        end

        it "should not calculate if there is no real_price" do
          deal.real_price = nil
          deal.discount = nil
          deal.calculate_discount

          deal.discount.should == nil
        end
      end
    end
  end

  describe "Daily Deals" do
    let(:deal) { FactoryGirl.build :daily_deal }
    subject { deal }

    it_should_behave_like "All Deals"
    it_should_behave_like "Not On Sale Deals"

    describe "Validations" do
      it "should require a price if the kind is daily deal" do
        deal.price_mask = nil
        deal.should_not be_valid
      end

      it "should be required when the kind is daily deal" do
        deal.real_price_mask = nil
        deal.should_not be_valid
      end
      describe "#calculate_discount" do
        it "should be calculated on validation" do
          deal.should_receive(:calculate_discount)
          deal.valid?
        end
        it "should calculate the percentage of discount" do
          deal.real_price = 2
          deal.price = 1.5
          deal.calculate_discount

          deal.discount.should == 25
        end

        it "should not calculate if there is no real_price" do
          deal.real_price = nil
          deal.discount = nil
          deal.calculate_discount

          deal.discount.should == nil
        end
      end
    end
  end

  describe "Categories" do
    it "CATEGORIES should return all categories" do
      Deal::CATEGORIES.should =~ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    end

    specify "RESTAURANT: should be equal 1" do
      Deal::CATEGORY_RESTAURANT.should == 1
    end
    
    specify "BEAUTY_AND_HEALTH: should be equal 2" do
      Deal::CATEGORY_BEAUTY_AND_HEALTH.should == 2
    end

    specify "ELECTRONICS: should be equal 3" do
      Deal::CATEGORY_ELECTRONICS.should == 3
    end

    specify "CULTURE: should be equal 4" do
      Deal::CATEGORY_CULTURE.should == 4
    end

    specify "HOME_AND_APPLIANCE: should be equal 5" do
      Deal::CATEGORY_HOME_AND_APPLIANCE.should == 5
    end

    specify "FITNESS: should be equal 6" do
      Deal::CATEGORY_FITNESS.should == 6
    end

    specify "COMPUTER: should be equal 7" do
      Deal::CATEGORY_COMPUTER.should == 7
    end

    specify "CLOTHES: should be equal 8" do
      Deal::CATEGORY_CLOTHES.should == 8
    end

    specify "TRAVEL: should be equal 9" do
      Deal::CATEGORY_TRAVEL.should == 9
    end

    specify "KIDS: should be equal 10" do
      Deal::CATEGORY_KIDS.should == 10
    end

    specify "CAR: should be equal 11" do
      Deal::CATEGORY_CAR.should == 11
    end

    specify "OTHER: should be equal 12" do
      Deal::CATEGORY_OTHER.should == 12
    end

    describe "categories dictionary" do

      it "should return CATEGORY_RESTAURANT if we pass 'restaurant' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["restaurant"].should == Deal::CATEGORY_RESTAURANT
      end

      it "should return CATEGORY_BEAUTY_AND_HEALTH if we pass 'beauty_and_health' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["beauty_and_health"].should == Deal::CATEGORY_BEAUTY_AND_HEALTH
      end

      it "should return CATEGORY_ELECTRONICS if we pass 'eletrocnics' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["electronics"].should == Deal::CATEGORY_ELECTRONICS
      end

      it "should return CATEGORY_CULTURE if we pass 'culture' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["culture"].should == Deal::CATEGORY_CULTURE
      end

      it "should return CATEGORY_HOME_AND_APPLIANCE if we pass 'home_and_appliance' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["home_and_appliance"].should == Deal::CATEGORY_HOME_AND_APPLIANCE
      end

      it "should return CATEGORY_FITNESS if we pass 'fitness' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["fitness"].should == Deal::CATEGORY_FITNESS
      end

      it "should return CATEGORY_COMPUTER if we pass 'computer' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["computer"].should == Deal::CATEGORY_COMPUTER
      end

      it "should return CATEGORY_CLOTHES if we pass 'clothes' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["clothes"].should == Deal::CATEGORY_CLOTHES
      end

      it "should return CATEGORY_TRAVEL if we pass 'travel' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["travel"].should == Deal::CATEGORY_TRAVEL
      end

      it "should return CATEGORY_KIDS if we pass 'kids' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["kids"].should == Deal::CATEGORY_KIDS
      end

      it "should return CATEGORY_CAR if we pass 'car' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["car"].should == Deal::CATEGORY_CAR
      end

      it "should return CATEGORY_OTHER if we pass 'others' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["others"].should == Deal::CATEGORY_OTHER
      end
    end

    describe "i18n" do
      specify "i18n_categories should return all categories' i18n name" do
        categories = []
        Deal::CATEGORIES.each do |id|
          categories << [Deal.i18n_category(id), id]
        end

        Deal.i18n_categories.should =~ categories
      end

      describe "pt-BR" do
        
        specify "RESTAURANT: should be equal 'Restaurantes'" do
          Deal.i18n_category(Deal::CATEGORY_RESTAURANT).should == 'Restaurantes'
        end

        specify "BEAUTY AND HEALTH: should be equal 'Beleza e Saúde'" do
          Deal.i18n_category(Deal::CATEGORY_BEAUTY_AND_HEALTH).should == 'Beleza e Saúde'
        end

        specify "ELETRONICS: should be equal 'Eletrônicos'" do
          Deal.i18n_category(Deal::CATEGORY_ELECTRONICS).should == 'Eletrônicos'
        end

        specify "CULTURE: should be equal 'Cultura'" do
          Deal.i18n_category(Deal::CATEGORY_CULTURE).should == 'Cultura'
        end

        specify "HOME AND APPLIANCE: should be equal 'Eletrodomésticos'" do
          Deal.i18n_category(Deal::CATEGORY_HOME_AND_APPLIANCE).should == 'Eletrodomésticos'
        end

        specify "FITNESS: should be equal 'Esportes e Lazer'" do
          Deal.i18n_category(Deal::CATEGORY_FITNESS).should == 'Esportes e Lazer'
        end

        specify "COMPUTER: should be equal 'Informática'" do
          Deal.i18n_category(Deal::CATEGORY_COMPUTER).should == 'Informática'
        end

        specify "CLOTHES: should be equal 'Roupas e Calçados'" do
          Deal.i18n_category(Deal::CATEGORY_CLOTHES).should == 'Roupas e Calçados'
        end

        specify "TRAVEL: should be equal 'Viagens'" do
          Deal.i18n_category(Deal::CATEGORY_TRAVEL).should == 'Viagens'
        end

        specify "KIDS: should be equal 'Infantil'" do
          Deal.i18n_category(Deal::CATEGORY_KIDS).should == 'Infantil'
        end

        specify "CAR: should be equal 'Artigos e peças automotivas'" do
          Deal.i18n_category(Deal::CATEGORY_CAR).should == 'Artigos automotivos'
        end
        
        specify "OTHER: should be equal 'Diversos'" do
          Deal.i18n_category(Deal::CATEGORY_OTHER).should == 'Diversos'
        end
      end
    end
  end

  describe "KINDS" do
    it "should return all kinds" do
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

    describe "i18n" do
      specify "i18n_kinds should return all kinds' i18n name" do
        kinds = []
        Deal::KINDS.each do |id|
          kinds << [Deal.i18n_kind(id), id]
        end

        Deal.i18n_kinds.should =~ kinds
      end

      describe "pt-BR" do
        specify "OFFER: should be equal 'Ofertas'" do
          Deal.i18n_kind(Deal::KIND_OFFER).should == 'Ofertas'
        end

        specify "DAILY_DEAL: should be equal 'Compras Coletivas'" do
          Deal.i18n_kind(Deal::KIND_DAILY_DEAL).should == 'Compras Coletivas'
        end

        specify "ON_SALE: should be equal 'Liquidação'" do
          Deal.i18n_kind(Deal::KIND_ON_SALE).should == 'Liquidação'
        end
      end
    end
  end

end
