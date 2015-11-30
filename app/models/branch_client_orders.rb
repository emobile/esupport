class BranchClientOrders < ActiveRecord::Base
  belongs_to :branch
  belongs_to :client
  belongs_to :order
  # attr_accessible :title, :body
end
