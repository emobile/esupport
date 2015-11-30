class ClientNeed < ActiveRecord::Base
  belongs_to :branch
  has_many :order_client_needs
  has_many :orders, :through => :order_client_needs
  attr_accessible :cost, :description, :name, :branch_id
  validates :cost, :name, :branch_id, :presence => true
  validates_length_of :name, :maximum => 150
  validates_length_of :description, :maximum => 3000
  validates_format_of :cost, :with => /\A((0|[1-9]\d*)([.]\d{0,2})?|[.]\d{1,2})\z/
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