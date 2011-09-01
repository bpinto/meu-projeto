# coding: utf-8
class Deal < ActiveRecord::Base
  has_paper_trail

  CATEGORY_DRINK = 1
  CATEGORY_BEAUTY_AND_HEALTH = 2
  CATEGORY_PHONE_AND_CAMERA = 3
  CATEGORY_MUSIC_AND_MOVIE = 4
  CATEGORY_HOME_AND_APPLIANCE = 5
  CATEGORY_ELECTRONICS = 6
  CATEGORY_FITNESS = 7
  CATEGORY_COMPUTER = 8
  CATEGORY_BOOK = 9
  CATEGORY_CLOTHES = 10
  CATEGORY_TRAVEL = 11
  CATEGORY_RESTAURANT = 12
  CATEGORY_TOY = 13
  CATEGORY_CAR = 14

  CATEGORIES = [ CATEGORY_DRINK, CATEGORY_BEAUTY_AND_HEALTH, CATEGORY_PHONE_AND_CAMERA, CATEGORY_MUSIC_AND_MOVIE,CATEGORY_HOME_AND_APPLIANCE, CATEGORY_ELECTRONICS, CATEGORY_FITNESS, CATEGORY_COMPUTER, CATEGORY_BOOK, CATEGORY_CLOTHES, CATEGORY_TRAVEL, CATEGORY_RESTAURANT,CATEGORY_TOY, CATEGORY_CAR ]

  #Pra que esse dicionário?
  CATEGORIES_DICTIONARY = {"drink" => CATEGORY_DRINK, "beauty_and_health" => CATEGORY_BEAUTY_AND_HEALTH, "phone_and_camera" => CATEGORY_PHONE_AND_CAMERA, "music_and_movie" => CATEGORY_MUSIC_AND_MOVIE, "home_and_appliance" => CATEGORY_HOME_AND_APPLIANCE, "electronics" => CATEGORY_ELECTRONICS, "fitness" => CATEGORY_FITNESS, "computer" => CATEGORY_COMPUTER, "book" => CATEGORY_BOOK, "clothes" => CATEGORY_CLOTHES, "travel" => CATEGORY_TRAVEL, "restaurant" => CATEGORY_RESTAURANT, "toy" => CATEGORY_TOY, "car" => CATEGORY_CAR}

  KIND_OFFER = 1
  KIND_DAILY_DEAL = 2
  KIND_ON_SALE = 3

  KINDS = [ KIND_OFFER, KIND_DAILY_DEAL, KIND_ON_SALE]

  belongs_to :city
  belongs_to :user

  validates :category,    :presence => true,      :inclusion => CATEGORIES
  validates :company,     :presence => true
  validates :description, :presence => true
  validates :discount,    :presence => true,      :if => "on_sale?"
  validates :end_date,    :timeliness => {:after => :now},  :allow_nil => true
  validates :kind,        :presence => true,      :inclusion => KINDS
  validates :link,        :presence => true,      :format => /^https?:\/\/.+/
  validates :price,       :numericality => true,  :unless => "on_sale?"
  validates :real_price,  :numericality => true,  :unless => "on_sale?"
  validates :real_price,  :greater_than => :price, :if => "price? and real_price?"

  validates :title,       :presence => true
  validates :city_id,     :presence => true

  after_validation :calculate_discount, :if => "real_price? and price? and not on_sale?"

  attr_accessible :address, :category, :city_id, :company, :description, :discount, :end_date, :kind, :link, :price, :real_price, :title

  #TODO: Remover o default_scope
  default_scope order("deals.created_at desc")
  # scope :recent, order("deals.created_at DESC")

  scope :today, where("deals.created_at >= ?", Date.today)
  scope :active, where("deals.end_date >= ? OR deals.end_date is null", Date.today)

  def self.by_category(category)
    where(:category => category)
  end

  #TODO: refatorar para utilizar a tradução para buscar por id
  def self.by_category_string(category)
    where(:category => CATEGORIES_DICTIONARY[category])
  end

  def self.by_kind(kind)
    where(:kind => kind)
  end

  def self.by_description(description)
    where("deals.description LIKE ?", "%#{description}%")
  end

  def self.by_title(title)
    where("deals.title LIKE ?", "%#{title}%")
  end

  def self.search(search)
    by_title(search).by_description(search)
  end

  def self.by_user_and_following(user)
    users = [user] + user.following
    where(:user_id => users)
  end

  def self.i18n_category(category)
    I18n.t("models.deal.category.#{category}")
  end

  def self.i18n_kind(kind)
    I18n.t("models.deal.kind.#{kind}")
  end

  def self.i18n_categories
    Deal::CATEGORIES.collect {|id| [Deal.i18n_category(id), id]}
  end

  def self.i18n_kinds
    Deal::KINDS.collect {|id| [Deal.i18n_kind(id), id]}
  end

  def calculate_discount
    (self.discount = (self.real_price - self.price)/self.real_price * 100).to_i if self.real_price?
  end

  private

  def on_sale?
    self.kind == KIND_ON_SALE
  end
end
