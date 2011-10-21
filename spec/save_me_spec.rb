require 'spec_helper'
require './lib/save_me.rb'

describe SaveMe do
  before(:each) do
    Factory.create :user, :username => "dealwitme"
  end

  let(:saveme) { SaveMe.new }
  subject { saveme }

  it "should use the 'dealwitme' user" do
  end

  it "should stop if the user 'dealwitme' does not exist" do
    User.delete_all
    lambda { saveme }.should raise_error(Exception, "User 'dealwitme' not found")
  end
end
