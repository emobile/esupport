class Cellphone < ActiveRecord::Base
  belongs_to :client
  belongs_to :branch
  has_many :order_cellphones
  has_many :orders, :through => :order_cellphones
  attr_accessible :color, :imei, :ope_system, :model, :brand, :client_id, :cellphone_id, :branch_id, :client_name
  attr_accessor :client_name
  validates :brand, :model, :imei, :branch_id, :client_id, :presence => true
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