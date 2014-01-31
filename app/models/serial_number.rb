class SerialNumber < ActiveRecord::Base
  belongs_to :part
  has_many :order_serial_number
  has_many :orders, :through => :order_serial_numbers
  attr_accessible :serial_number, :part_id
  
  validates :serial_number, :uniqueness => {:scope => :serial_number}
  validates :serial_number, :part_id, :presence => true
  validates_length_of :serial_number, :maximum => 150
end