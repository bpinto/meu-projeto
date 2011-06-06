class User < ActiveRecord::Base
  include  Gravtastic
  gravtastic

  devise :confirmable, :database_authenticatable, :recoverable,
         :registerable, :rememberable, :trackable, :validatable

  has_many :deals
  has_many :relationships
  has_many :followers, :through => :relationships

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
