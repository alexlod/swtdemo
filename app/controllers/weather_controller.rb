class WeatherController < ApplicationController
  before_filter :requires_login_or_redirect
  
  def show
    w_api = Wunderground.new
    
    @w_response = w_api.forecast_and_conditions_for(params[:zip])
    
    if @w_response["forecast"].nil?
      redirect_to :root, alert: "Weather for '#{params[:zip]}' couldn't be found."
    end
  end
  
  def send_text
    @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    
    @client.messages.create(
      from: ENV["TWILIO_FROM_NUMBER"],
      to: "+1#{params[:number]}",
      body: params[:message]
    )
    
    render nothing: true
  end
end
