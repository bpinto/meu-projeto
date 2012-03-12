# coding: utf-8
class Deal < ActiveRecord::Base
  acts_as_commentable

  make_voteable

  has_paper_trail

  self.per_page = 10

  CATEGORY_RESTAURANT = 1
  CATEGORY_BEAUTY_AND_HEALTH = 2
  CATEGORY_ELECTRONICS = 3
  CATEGORY_CULTURE = 4
  CATEGORY_HOME_AND_APPLIANCE = 5
  CATEGORY_FITNESS = 6
  CATEGORY_COMPUTER = 7
  CATEGORY_CLOTHES = 8
  CATEGORY_TRAVEL = 9
  CATEGORY_KIDS = 10
  CATEGORY_CAR = 11
  CATEGORY_OTHER = 12

  CATEGORIES = [ CATEGORY_RESTAURANT, CATEGORY_BEAUTY_AND_HEALTH, CATEGORY_ELECTRONICS, CATEGORY_CULTURE,CATEGORY_HOME_AND_APPLIANCE, CATEGORY_FITNESS, CATEGORY_COMPUTER, CATEGORY_CLOTHES, CATEGORY_TRAVEL, CATEGORY_KIDS, CATEGORY_CAR, CATEGORY_OTHER ]

  #Pra que esse dicionário?
  #TODO: refatorar para utilizar a tradução para buscar por id
  CATEGORIES_DICTIONARY = {"restaurant" => CATEGORY_RESTAURANT, "beauty_and_health" => CATEGORY_BEAUTY_AND_HEALTH, "electronics" => CATEGORY_ELECTRONICS, "culture" => CATEGORY_CULTURE, "home_and_appliance" => CATEGORY_HOME_AND_APPLIANCE, "fitness" => CATEGORY_FITNESS, "computer" => CATEGORY_COMPUTER, "clothes" => CATEGORY_CLOTHES, "travel" => CATEGORY_TRAVEL, "kids" => CATEGORY_KIDS, "car" => CATEGORY_CAR, "others" => CATEGORY_OTHER}

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
  validates :end_date,    :date => {:after_or_equal_to => Date.today},  :allow_nil => true
  validates :image_url,   :format => /(^$)|(^https?:\/\/.+)/
  validates :kind,        :presence => true,      :inclusion => KINDS
  validates :link,        :presence => true,      :uniqueness => true,  :format => /^https?:\/\/.+/
  validates :price,       :numericality => true,  :unless => "on_sale?"
  validates :real_price,  :numericality => true,  :unless => "on_sale?"
  validates :real_price,  :greater_than => :price, :if => "price? and real_price?"

  validates :title,       :presence => true,      :length => { :maximum => 255 }
  validates :city_id,     :presence => true
  validates :user,        :presence => true

  # VALIDAÇÕES PARA A MÁSCARA DE PREÇO
  validates :price_mask,  :presence => true,      :unless => "on_sale? || price?"
  validates :real_price_mask,  :presence => true, :unless => "on_sale? || real_price?"

  after_validation :calculate_discount, :if => "real_price? and price? and not on_sale?"
  before_validation :prices_to_number, :if => "not on_sale?"
  before_create :add_affiliate_code_to_link

  attr_accessor :price_mask, :real_price_mask
  attr_accessible :address, :category, :city_id, :company, :description, :discount, :end_date, :image_url, :kind, :link, :price, :price_mask, :real_price, :real_price_mask, :title, :user_id

  scope :recent, order("deals.created_at DESC")
  scope :lowest_price, order("deals.price ASC")
  scope :highest_price, order("deals.price DESC")
  scope :highest_discount, order("deals.discount DESC")
  scope :best_deals, order("(deals.up_votes / (deals.up_votes + deals.down_votes)) DESC")
  scope :most_commented, order("(select count(comments.id) from comments where comments.commentable_id = deals.id) DESC")

  scope :today, where("deals.created_at >= ?", Date.today)
  scope :active, where("deals.end_date >= ? OR deals.end_date is null", Date.today)
  scope :voted, where("(deals.up_votes + deals.down_votes) > 0")


  def self.by_category(category)
    where(:category => category)
  end

  #TODO: refatorar para utilizar a tradução para buscar por id
  def self.by_category_string(category)
    where(:category => CATEGORIES_DICTIONARY[category])
  end

  def self.by_cities(cities_id)
    where(:city_id => cities_id)
  end

  def self.by_kind(kind)
    where(:kind => kind)
  end

  def self.by_link(link)
    where(:link => link).first
  end

  def self.search(search)
    where("deals.title ILIKE :search OR deals.description ILIKE :search", :search => "%#{search}%")
  end

  def self.by_username_and_following(username)
    user_id = User.find_by_username(username).id
    users = [user_id] + Relationship.followed_ids(user_id)
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

  def already_shared?
    Deal.by_link(self.link)
  end

  def average
    ((self.up_votes * 100)/self.votings.length).to_i if self.votings.length != 0
  end

  def discount_to_percentage
    ((self.discount / self.real_price) * 100).to_i if self.real_price?
  end

  def calculate_discount
    (self.discount = ((self.real_price - self.price)/self.real_price * 100).to_i) if self.real_price?
  end

  def prices_to_number
    self.price = to_number(self.price_mask) if self.price_mask
    self.real_price = to_number(self.real_price_mask) if self.real_price_mask
  end

  def add_affiliate_code_to_link
    if self.link.match(Share::COMPRA_FACIL)
      self.link = self.link.strip + "&a_aid=OfertuSCF"
    end
  end

  private

  def on_sale?
    self.kind == KIND_ON_SALE
  end

  def to_number(mask)
    return mask.gsub(/[^\d]/,'').to_f/100
  end
end
