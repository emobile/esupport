class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_login_type
  
  def get_login_type
    if signed_in?
      @current_user = current_user.nil? ? current_client : current_user 
      if current_user.blank?
        @is_user = false
      end
      if current_client.blank?
        @is_user = true
      end
    end
  end
  if Rails.env == "production" or Rails.env == "development" or Rails.env == "local"
    if @is_user
      @branch = @current_user.branch_id
    else
      @branch = 0
    end
#    rescue_from Exception do |exception|#WORKS
#      line_number = exception.backtrace.to_s.split(":in").first.gsub("[\"", "")
#      flash[:error] = t(:something_wrong, :exeption => exception.to_s)
#      ErrorReport.create(:user => signed_in? ? current_user.fullname : "Guess User" , :controller_name => controller_name, :action_name => action_name, :description => exception.to_s, :referrer_url => request.referer, :original_path => request.env['ORIGINAL_FULLPATH'], :branch_id => @branch, :environment => Rails.env, :error_time => Time.now - 6.hours, :line_number => line_number, :backtrace => exception.backtrace)
#      render welcome_index_path
#    end
#    rescue_from ActiveRecord::RecordNotFound do |exception|#WORKS
#      line_number = exception.backtrace.to_s.split(":in").first.gsub("[\"", "")
#      flash[:error] = t(:something_wrong, :exeption => exception.to_s)
#      ErrorReport.create(:user => signed_in? ? current_user.fullname : "Guess User" , :controller_name => controller_name, :action_name => action_name, :description => exception.to_s, :referrer_url => request.referer, :original_path => request.env['ORIGINAL_FULLPATH'], :branch_id => @branch, :environment => Rails.env, :error_time => Time.now - 6.hours, :line_number => line_number, :backtrace => exception.backtrace)
#      render welcome_index_path
#    end 
    #    rescue_from ActionController::UnknownController do |exception|
    #      flash[:error] = t(:something_wrong, :exeption => exception.to_s)
    #      render warnings_no_access_path
    #      ErrorReport.create(:user => signed_in? ? current_user.fullname : "Default User" , :controller_name => controller_name, :action_name => action_name, :description => exception.to_s, :referrer_url => request.referer, :original_path => request.env['ORIGINAL_FULLPATH'], :library_id => @current_library.id, :environment => Rails.env, :other => Time.now - 6.hours)
    #    end 
    #    rescue_from ActionController::UnknownAction do |exception|
    #      flash[:error] = t(:something_wrong, :exeption => exception.to_s)
    #      render warnings_no_access_path
    #      ErrorReport.create(:user => signed_in? ? current_user.fullname : "Default User" , :controller_name => controller_name, :action_name => action_name, :description => exception.to_s, :referrer_url => request.referer, :original_path => request.env['ORIGINAL_FULLPATH'], :library_id => @current_library.id, :environment => Rails.env, :other => Time.now - 6.hours)
    #    end 
    #    rescue_from AbstractController::ActionNotFound do |exception|
    #      flash[:error] = t(:something_wrong, :exeption => exception.to_s)
    #      render warnings_no_access_path
    #      ErrorReport.create(:user => signed_in? ? current_user.fullname : "Default User" , :controller_name => controller_name, :action_name => action_name, :description => exception.to_s, :referrer_url => request.referer, :original_path => request.env['ORIGINAL_FULLPATH'], :library_id => @current_library.id, :environment => Rails.env, :other => Time.now - 6.hours)
    #    end 
  end
end
