class User < ActiveRecord::Base
  include  Gravtastic
  gravtastic

  devise :confirmable, :database_authenticatable, :recoverable,
         :registerable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
