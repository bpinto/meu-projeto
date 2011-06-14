class User < ActiveRecord::Base
  include  Gravtastic
  gravtastic

  devise :confirmable, :database_authenticatable, :recoverable,
         :registerable, :rememberable, :trackable, :validatable

  has_many :deals
  has_many :relationships,          :foreign_key => "follower_id"#,      :dependent => :destroy
  has_many :followers,              :through => :reverse_relationships, :source => :follower
  has_many :following,              :through => :relationships,         :source => :followed
  has_many :reverse_relationships,  :foreign_key => "followed_id",      :class_name => "Relationship"#,      :dependent => :destroy

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  def follow!(another_user)
    relationships.create! :followed_id => another_user.id
  end

  def unfollow!(another_user)
    relationships.find_by_followed_id(another_user.id).destroy
  end

  def follow?(another_user)
    relationships.exists? :followed_id => another_user.id
  end
end
