ENV['RAILS_ENV'] ||= 'production'
ENV['HOME'] ||= `echo ~`.strip
ENV['GEM_HOME'] = File.expand_path('/usr/local/rvm/gems/ruby-1.9.3-p429i')
ENV['GEM_PATH'] = File.expand_path('/usr/local/rvm/gems/ruby-1.9.3-p429') + ":" +
File.expand_path('/usr/local/rvm/gems/ruby-1.9.3-p429@global')

require 'fcgi'
require File.join(File.dirname(__FILE__), '../config/environment.rb')

class Rack::PathInfoRewriter
def initialize(app)
@app = app
end

def call(env)
env.delete('SCRIPT_NAME')
parts = env['REQUEST_URI'].split('?')
env['PATH_INFO'] = parts[0]
env['QUERY_STRING'] = parts[1].to_s
@app.call(env)
end
end
Rack::Handler::FastCGI.run  Rack::PathInfoRewriter.new(ADM::Application)
