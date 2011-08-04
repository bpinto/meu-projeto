# coding: utf-8
class Deal < ActiveRecord::Base

  CATEGORY_DRINK = 1
  CATEGORY_BEAUTY_AND_HEALTH = 2
  CATEGORY_PHONE_AND_CAMERA = 3
  CATEGORY_CD_AND_DVD = 4
  CATEGORY_HOME_AND_APPLIANCE = 5
  CATEGORY_ELETRONICS = 6
  CATEGORY_FITNESS = 7
  CATEGORY_COMPUTER = 8
  CATEGORY_BOOK = 9
  CATEGORY_CLOTHES = 10
  CATEGORY_TRAVEL = 11
  CATEGORY_RESTAURANT = 12
  CATEGORY_TOY = 13
  CATEGORY_CAR = 14

  CATEGORIES = [ CATEGORY_DRINK, CATEGORY_BEAUTY_AND_HEALTH, CATEGORY_PHONE_AND_CAMERA, CATEGORY_CD_AND_DVD, CATEGORY_HOME_AND_APPLIANCE,  CATEGORY_ELETRONICS, CATEGORY_FITNESS, CATEGORY_COMPUTER, CATEGORY_BOOK, CATEGORY_CLOTHES, CATEGORY_TRAVEL, CATEGORY_RESTAURANT,  CATEGORY_TOY, CATEGORY_CAR ]

  belongs_to :user

  validates :category,    :presence => true,      :inclusion => CATEGORIES
  validates :company,     :presence => true
  validates :description, :presence => true
  validates :discount,    :inclusion => [nil],    :unless => "self.real_price?"
  validates :kind,        :presence => true
  validates :link,        :presence => true,      :format => /^https?:\/\/.+/
  validates :price,       :numericality => true
  validates :real_price,  :numericality => true,  :greater_than => :price,  :if => "self.real_price?"
  validates :title,       :presence => true

  after_validation :calculate_discount

  attr_accessible :address, :category, :company, :description, :end_date, :kind, :link, :price, :title


  default_scope order("created_at desc")

  scope :today, where("deals.created_at >= ?", Date.today)

  def self.category(category)
    where(:category => category)
  end

  def discount_to_percentage
    (self.discount / self.real_price) * 100 if self.real_price?
  end

  def calculate_discount
    (self.discount = self.real_price - self.price) if self.real_price?
  end

  def self.categories
    Deal::CATEGORIES.each {|id| [id, I18n.t("models.deal.category.#{id}")]}
  end
end
