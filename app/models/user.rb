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

  validates :username,  :presence => true,  :uniqueness => true

  attr_accessible :email, :login, :name, :password, :password_confirmation, :remember_me, :username

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  def follow!(another_user)
    relationships.create! :followed_id => another_user.id
  end

  def unfollow!(another_user)
    relationships.find_by_followed_id(another_user.id).destroy
  end

  def follow?(another_user)
    relationships.exists? :followed_id => another_user.id
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
