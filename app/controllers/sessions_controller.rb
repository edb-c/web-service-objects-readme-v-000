class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['4MQQ4N4I4LSFWHA3KHVOIFULMGDTABASLWHUKF3CGDYEIERO']
      req.params['client_secret'] = ENV['YM3CJJ5FX43YZKL5CKOUKRTP5KSSCUH2R0M22Z3KZ3HBWVAM']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
