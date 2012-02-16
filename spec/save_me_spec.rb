require 'spec_helper'
require './lib/save_me.rb'

describe SaveMe do
  before(:each) do
    Factory.create :user, :username => "ofertus"
  end

  let(:saveme) { SaveMe.new }
  subject { saveme }

  it "should use the 'ofertus' user" do
  end

  it "should stop if the user 'ofertus' does not exist" do
    User.delete_all
    lambda { saveme }.should raise_error(Exception, "User 'ofertus' not found")
  end
end
