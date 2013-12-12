class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :confirmable 
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :confirmed_at, :fullname
  attr_accessible :first_name, :last_name,:phone1,:phone2,:address1,:address2,:city, :country, :state, :zip, :login, :active, :country, :fax, :branch_id, :role_id, :active
  attr_accessor :login, :fullname, :role_id
  has_many :cellphones, :dependent => :destroy
  has_many :computers, :dependent => :destroy
  has_many :bills, :dependent => :destroy
  attr_accessible :bills_attributes
  accepts_nested_attributes_for :bills, :allow_destroy => true
  has_many :orders, :dependent => :destroy
  #has_many :orders, :foreign_key => 'seller_id', :class_name => "Order"
  #has_many :orders, :foreign_key => 'driver_id', :class_name => "Route"
  #Email and password are not include in validates precense => true since it is validated by devise  
  validates :first_name, :last_name, :presence => true
  validates :username, :uniqueness => true
  validates_length_of :email, :maximum => 120
  validates_length_of :first_name, :last_name, :maximum => 30
  validates :username, :length => { :within => 8..30 }, :allow_blank => true
  validates :password, :length => { :within => 8..30 },  :allow_blank => true
  validates_format_of :email, :with => /^\w+([\.-]?\w+)*@[a-zA-Z0-9]+([\.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,3})+$/i, :allow_blank => true
  validates_format_of :username, :with => /^[\w\._]+$/i, :allow_blank => true, :message => "solo debe contener _ . letras o numeros."  
  validates_format_of :password, :with => /^[\w]+$/i, :allow_blank => true, :message => "solo debe contener letras y numeros."
  self.per_page = 15
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
  #protected

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

  public
  
  def fullname
    first_name.titlecase + " " + last_name.titlecase 
  end
  
  def name_username
    first_name.titlecase + " " + last_name.titlecase + " (" + username + ")"
  end 
  
  def name_client_id
    first_name.titlecase + " " + last_name.titlecase + " ( Client No: " + id + ")"
  end 
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |model|
        csv << model.attributes.values_at(*column_names)
      end
    end
  end
end
