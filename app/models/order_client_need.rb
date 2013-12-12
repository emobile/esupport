class OrderClientNeed < ActiveRecord::Base
  belongs_to :order
  belongs_to :client_need
  attr_accessible :order_id, :client_need_id
end
