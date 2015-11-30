class Progress < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :branch
  attr_accessible :full_description, :short_description, :user_id, :order_id, :branch_id
  validates :full_description, :short_description, :user_id, :order_id, :branch_id, :presence => true
  validates_length_of :short_description, :maximum => 150
  validates_length_of :full_description, :maximum => 3000
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