class BranchClients < ActiveRecord::Base
  belongs_to :branch
  belongs_to :client
  # attr_accessible :title, :body
end
