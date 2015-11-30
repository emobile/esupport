class ErrorReport < ActiveRecord::Base
  belongs_to :branch
  attr_accessible :action_name, :backtrace, :controller_name, :description, :environment, :error_time, :line_number, :original_path, :referrer_url, :user, :branch_id
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
