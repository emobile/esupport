class OrderPart < ActiveRecord::Base
  belongs_to :order
  belongs_to :part
  attr_accessible :order_id, :part_id
end
