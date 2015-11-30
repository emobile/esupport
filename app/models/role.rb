class Role < ActiveRecord::Base
  belongs_to :branch
  has_many :users, :dependent => :destroy
  attr_accessible :description, :name, :branch_id, :protected, :super_admin, :branch_admin, :orders_admin, :secretary, :client
  validates :description, :name, :branch_id, :presence => true
  validates_length_of :name, :maximum => 150
  validates_length_of :description, :maximum => 3000
  self.per_page = 10
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |model|
        csv << model.attributes.values_at(*column_names)
      end
    end
  end
end
