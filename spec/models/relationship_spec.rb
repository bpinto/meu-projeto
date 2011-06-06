require 'spec_helper'

describe Relationship do
  let(:relationship) { Factory.build :relationship }
  subject { relationship }

  #its(:save) { should be_true } TODO: Descomentar depois de criar a factory

  it { should respond_to :follower }
  it { should respond_to :followed }

  #TODO: Testar que o follower e o followed não podem ficar vazios
end
