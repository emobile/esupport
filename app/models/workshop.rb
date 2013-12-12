class Workshop < ActiveRecord::Base
  belongs_to :user
  belongs_to :branch
  has_many :orders, :dependent => :destroy
  attr_accessible :address1, :address2, :city, :country, :description, :email1, :email2, :fax, :name, :phone1, :phone2, :state, :zip, :user_id, :branch_id
  validates :address1, :city, :country, :description, :email1, :name, :phone1, :state, :zip, :user_id, :branch_id, :presence => true
  validates :name, :uniqueness => true
  validates_length_of :email1, :email2, :maximum => 120
  validates_format_of :email1, :email2, :with => /^\w+([\.-]?\w+)*@[a-zA-Z0-9]+([\.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,3})+$/i, :allow_blank => true
  validates_length_of :name, :maximum => 150
  validates_length_of :address1, :address2, :maximum => 100
  validates_length_of :city, :country, :state, :maximum => 50
  validates_length_of :zip, :is => 5, :allow_blank => true
  validates_format_of :zip, :with => /\A\d*\z/, :allow_nil => true
  self.per_page = 10
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |model|
        csv << model.attributes.values_at(*column_names)
      end
    end
  end
end