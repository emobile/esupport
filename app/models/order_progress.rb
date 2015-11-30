class OrderProgress < ActiveRecord::Base
  belongs_to :order
  belongs_to :progress
  attr_accessible :order_id, :progress_id
end
