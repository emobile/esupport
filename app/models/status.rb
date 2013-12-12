class Status < ActiveRecord::Base
  belongs_to :branch
  has_many :orders
  attr_accessible :description, :name, :hierarchy, :branch_id
  validates :description, :name, :hierarchy, :branch_id, :presence => true
  validates_length_of :name, :maximum => 150
  validates_format_of :hierarchy, :with => /\A\d*\z/
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
