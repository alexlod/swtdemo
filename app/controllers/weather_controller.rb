class WeatherController < ApplicationController
  before_filter :requires_login_or_redirect
  
  def show
    w_api = Wunderground.new
    @forecast = w_api.forecast_for(params[:zip])
    if @forecast["forecast"].nil?
      redirect_to :root, alert: "Weather for '#{params[:zip]}' couldn't be found."
    end
  end
end
