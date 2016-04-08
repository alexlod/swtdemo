class SessionsController < ApplicationController
  before_filter :requires_login_or_redirect, only: [:destroy]
  
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to :root, notice: "You have been signed in."
  end
  
  def destroy
    session[:user_id] = nil;
    redirect_to :root, notice: "You have been signed out."
  end
  
  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
