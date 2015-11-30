class Order < ActiveRecord::Base
  belongs_to :client
  belongs_to :cellphone
  belongs_to :computer
  belongs_to :workshop
  belongs_to :bill
  belongs_to :status
  belongs_to :branch
  has_many :progresses, :dependent => :destroy
  has_many :order_progresses, :dependent => :destroy
  has_many :order_serial_numbers, :dependent => :destroy
  has_many :serial_numbers, :through => :order_serial_numbers, :uniq => true
  has_many :parts, :through => :serial_numbers
  attr_accessible :order_serial_numbers_attributes
  accepts_nested_attributes_for :order_serial_numbers, :allow_destroy => true
  has_many :order_client_needs, :dependent => :destroy
  has_many :client_needs, :through => :order_client_needs, :uniq => true
  attr_accessible :order_client_needs_attributes
  accepts_nested_attributes_for :order_client_needs, :allow_destroy => true
  has_many :order_cellphones
  has_many :cellphones, :through => :order_cellphones
  attr_accessible :cellphones_attributes
  accepts_nested_attributes_for :cellphones, :allow_destroy => true
  has_many :order_computers
  has_many :computers, :through => :order_computers
  attr_accessible :computers_attributes
  accepts_nested_attributes_for :computers, :allow_destroy => true 
  
  attr_accessible :accessories, :comments, :condition, :failure, :client_id, :product_type, :workshop_id, :bill_id, :require_bill, :status_id, :branch_id, :total_due, :delivery_date, :identifier
  validates :identifier, :condition, :failure, :client_id, :product_type, :workshop_id, :status_id, :branch_id, :bill_id, :delivery_date, :presence => true
  attr_accessor  :full_description, :short_description, :editing, :branch_id, :user_id
  attr_accessible :full_description, :short_description, :editing, :branch_id, :user_id
  attr_accessible :order_progresses_attributes
  validates :full_description, :short_description, :presence => true, :if => Proc.new { |order| order.editing == true}
  
  #  attr_accessor :color, :imei, :ope_system, :model, :brand
  #  attr_accessible :color, :imei, :ope_system, :model, :brand
  #  validates :brand, :model, :imei, :branch_id, :client_id, :presence => true, :if =>  Proc.new { |order| order.product_type == "Cellphone"}
  #  attr_accessor :brand, :charger, :color, :hard_drive, :keyboard, :memory, :model, :monitor, :mouse, :serial_number, :type, :units, :usb, :computer_type, :proccessor, :ope_system
  #  attr_accessible :brand, :charger, :color, :hard_drive, :keyboard, :memory, :model, :monitor, :mouse, :serial_number, :type, :units, :usb, :computer_type, :proccessor, :ope_system
  #  validates :brand, :model, :serial_number, :branch_id, :client_id, :presence => true, :if =>  Proc.new { |order| order.product_type == "Computer"}

  #  validates :client_needs, :presence => true
  #
  #  private
  #  def require_client_needs
  #    if self.client_needs.size < 1 
  #      errors.add(:base, "Debe agregar por lo menos un requerimiento del cliente")
  #    end
  #  end

#  validate :must_have_one_client_need
#
#  private
#  def must_have_one_client_need
#    if client_needs_empty
#      errors.add(:client_needs)
#      if action_name == "update"
#        creators.reload()
#      end
#    end
#  end
  
  
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