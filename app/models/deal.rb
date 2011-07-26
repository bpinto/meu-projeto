# coding: utf-8
class Deal < ActiveRecord::Base
  KIND_DRINK = 1
  KIND_BEAUTY_AND_HEALTH = 2
  KIND_PHONE = 3
  KIND_CD_AND_DVD = 4
  KIND_HOME_AND_APPLIANCE = 5
  KIND_ELETRONICS = 6
  KIND_FITNESS = 7
  KIND_COMPUTER = 8
  KIND_BOOK = 9
  KIND_CLOTHES = 10
  KIND_TRAVEL = 11

  KINDS = [ KIND_DRINK, KIND_BEAUTY_AND_HEALTH, KIND_PHONE, KIND_CD_AND_DVD, KIND_HOME_AND_APPLIANCE,
            KIND_ELETRONICS, KIND_FITNESS, KIND_COMPUTER, KIND_BOOK, KIND_CLOTHES,
            KIND_TRAVEL ]


  #CATEGORIES = []

  belongs_to :user

  validates :category,    :presence => true
  validates :company,     :presence => true
  validates :description, :presence => true
  validates :discount,    :inclusion => [nil],    :unless => "self.real_price?"
  validates :kind,        :presence => true,      :inclusion => KINDS
  validates :link,        :presence => true,      :format => /^https?:\/\/.+/
  validates :price,       :numericality => true
  validates :real_price,  :numericality => true,  :greater_than => :price,  :if => "self.real_price?"
  validates :title,       :presence => true

  after_validation :calculate_discount

  attr_accessible :address, :category, :company, :description, :end_date, :kind, :link, :price, :title


  default_scope order("created_at desc")

  scope :today, where("deals.created_at >= ?", Date.today)

  def self.kind(kind)
    where(:kind => kind)
  end

  def discount_to_percentage
    (self.discount / self.real_price) * 100 if self.real_price?
  end

  def calculate_discount
    (self.discount = self.real_price - self.price) if self.real_price?
  end
end
