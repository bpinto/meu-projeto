class User < ActiveRecord::Base
  include  Gravtastic

  make_voter

  devise :confirmable, :database_authenticatable, :omniauthable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  gravtastic :size => 180, :default => "mm"
  has_paper_trail

  has_and_belongs_to_many :cities
  has_many :deals
  has_many :relationships,          :foreign_key => "follower_id"
  has_many :followers,              :through => :reverse_relationships, :source => :follower
  has_many :following,              :through => :relationships,         :source => :followed
  has_many :reverse_relationships,  :foreign_key => "followed_id",      :class_name => "Relationship"

  validates :username,  :presence => true,  :uniqueness => true,  :format => /^[a-zA-Z0-9_]{5,20}$/
  validates :credit,    :presence => true

  attr_accessible :access_token, :avatar_url, :credit, :facebook_follow_user, :facebook_vote_offer, :facebook_share_offer, :email, :login, :name, :password, :password_confirmation, :provider, :remember_me, :uid, :username

  before_validation :set_credit_to_zero

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  def set_credit_to_zero
    self.credit = 0 if not credit
  end

  def guest?
    self.new_record?
  end

  def follow!(another_user)
    relationships.create! :followed_id => another_user.id
  end

  def unfollow!(another_user)
    relationships.find_by_followed_id(another_user.id).destroy
  end

  def follow?(another_user)
    relationships.exists? :followed_id => another_user.id
  end

  def facebook_profile_picture(size = "large")
    FbGraph::User.fetch(uid).picture(size)
  end

  def self.by_username(username)
    where(:username => username).first
  end

  def self.search(search)
    where("users.name ILIKE :search OR users.username ILIKE :search", :search => "%#{search}%")
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data.email).first
      user.update_attributes!(:name => data.name, :avatar_url => data.image, :access_token => access_token.credentials.token)
      puts "INICIO INICIO ACCESS_TOKEN INICIO INICIO"
      puts access_token
      puts "FIM FIM ACCESS_TOKEN FIM FIM"
      user
    end
  end

  def self.apply_omniauth(data)
    user_info = data.info
    User.new(:email => user_info.email, :name => user_info.name, :username => user_info.nickname, :provider => "facebook", :uid => data.uid, :avatar_url => user_info.image, :confirmed_at => Date.today, :access_token => data.credentials.token)
  end

  def password_required?
    (provider.nil? || !password.blank?) && super
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end

    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end
