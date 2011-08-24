require 'spec_helper'

describe City do
  let(:city) { Factory.build :city }
  subject { city }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

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
end
