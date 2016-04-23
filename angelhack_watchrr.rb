require 'sinatra'
require 'sinatra/cross_origin'

require 'json'
require 'httparty'

require 'byebug'

API_KEY = 'AIzaSyCL9LZPG85foCDceeIs_pNHD4SfK8__7vk'

configure do
  enable :cross_origin
end

get "/search" do
  return "No `key` parameter is provided." unless params[:key]

  content_type :json

  request_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=#{params[:key]}&key=AIzaSyBRmc48TI0hNiirngfbuzpJ_DYQPqwsnGA"

  begin
    response = HTTParty.get(request_url)
    response.parsed_response["results"].to_json
  rescue => e
    e.message
  end
end
