class OrderComputer < ActiveRecord::Base
  belongs_to :order
  belongs_to :computer
  attr_accessible :order_id, :computer_id
end
