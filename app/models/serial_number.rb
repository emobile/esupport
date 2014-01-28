class SerialNumber < ActiveRecord::Base
  belongs_to :part
  attr_accessible :serial_number, :part_id
  
  validates :part_id, :uniqueness => {:scope => :serial_number}
  validates :serial_number, :part_id, :presence => true
  validates_length_of :serial_number, :maximum => 150
end