require 'not_equal_validator'

class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"

  validates :follower_id, :presence => true
  validates :followed_id, :presence => true, :uniqueness => { :scope => :follower_id } #TODO: Testar uniqueness
  validates :follower_id, :not_equal => { :with => :followed_id, :message => "You cannot follow yourself" }
end
