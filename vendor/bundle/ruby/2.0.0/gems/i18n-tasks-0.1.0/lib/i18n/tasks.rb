require 'i18n/tasks/version'
require 'i18n/tasks/railtie'
require 'active_support/hash_with_indifferent_access'

module I18n
  module Tasks
    mattr_accessor :get_locale_data
    self.get_locale_data = lambda { |locale|
      YAML.load_file("config/locales/#{locale}.yml")
    }

    CONFIG_FILE = 'config/i18n-tasks.yml'
    class << self
      def config
        @config ||= begin
          file = File.read(CONFIG_FILE) if File.exists?(CONFIG_FILE)
          file = YAML.load(file) if file.present?
          HashWithIndifferentAccess.new.merge(file.presence || {})
        end
      end
    end
  end
end
