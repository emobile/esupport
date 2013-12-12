class OrderCellphone < ActiveRecord::Base
  belongs_to :order
  belongs_to :cellphone
  attr_accessible :order_id, :cellphone_id
end
