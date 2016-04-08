class SessionsController < ApplicationController
  def create
    @auth_hash = auth_hash
  end
  
  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
