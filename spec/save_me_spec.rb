require 'spec_helper'
require './lib/save_me.rb'

describe SaveMe do
  let(:saveme) { SaveMe.new }
  subject { saveme }

  describe "#deals" do
    it "a" do
      City.create name: "Rio de Janeiro", state: "Rio de Janeiro", country: "Brasil"
      Factory.create :user, :username => "DealWitMe"
      saveme.deals
    end
  end
end
