class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  attr_reader :current_user
  helper_method :user_signed_in?, :current_user
  
  before_filter :setup_current_user
  
  protected
  
    def setup_current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id]) rescue nil
      end
    end
    
    def user_signed_in?
      ! @current_user.nil?
    end
end
