class Computer < ActiveRecord::Base
  belongs_to :client
  has_many :order_computers
  has_many :orders, :through => :order_computers
  belongs_to :branch
  attr_accessible :brand, :charger, :color, :hard_drive, :keyboard, :memory, :model, :monitor, :mouse, :serial_number, :type, :units, :usb, :client_id, :branch_id, :computer_type, :proccessor, :ope_system
  validates :brand, :model, :serial_number, :branch_id, :client_id, :presence => true
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