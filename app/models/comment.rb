class Comment < ActiveRecord::Base
  attr_accessible :comment, :email, :fullname
  validates :comment, :email, :fullname, :presence => true
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
