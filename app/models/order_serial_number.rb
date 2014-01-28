class OrderSerialNumber < ActiveRecord::Base
  belongs_to :order
  belongs_to :serial_number
  attr_accessible :order_id, :serial_number_id
end
