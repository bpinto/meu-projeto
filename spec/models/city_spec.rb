require 'spec_helper'

describe City do
  let(:city) { FactoryGirl.build :city }
  subject { city }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :users }
  it { should respond_to :deals }

  describe "Accessibility" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:state) }
    it { should allow_mass_assignment_of(:country) }
  end

  describe "Validations" do
    it "should require a name" do
      city.name = nil
      city.should_not be_valid
    end

    it "should require a state" do
      city.state = nil
      city.should_not be_valid
    end

    it "should require a country" do
      city.country = nil
      city.should_not be_valid
    end
  end

  describe "hash of states" do
    it "should return { a => [a, id]}" do
      city = City.create!(:name => "a", :state =>"a", :country=>"a")
      City.hash_by_states.should == {"a" => [["a", city.id]]}
    end

    it "should return { a => [a, id], b => [a, id]}" do
      city_a = City.create!(:name => "a", :state =>"a", :country=>"a")
      city_b = City.create!(:name => "a", :state =>"b", :country=>"a")
      City.hash_by_states.should == {"a" => [["a", city_a.id]], "b" => [["a", city_b.id]]}
    end


    it "should return { a => [[a, id]], b => [[a, id],[b,id]]}" do
      city_b = City.create!(:name => "a", :state =>"b", :country=>"a")
      city_a = City.create!(:name => "a", :state =>"a", :country=>"a")
      city_c = City.create!(:name => "b", :state =>"b", :country=>"a")
      City.hash_by_states.should == {"a" => [["a", city_a.id]], "b" => [["a", city_b.id],["b", city_c.id]]}
    end
  end
end
