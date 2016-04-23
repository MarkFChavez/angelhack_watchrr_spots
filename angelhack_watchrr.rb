require 'sinatra'
require 'sinatra/cross_origin'

require 'json'
require 'google_places'

require 'byebug'

API_KEY = 'AIzaSyCL9LZPG85foCDceeIs_pNHD4SfK8__7vk'

configure do
  enable :cross_origin
end

get "/search" do
  return "No `key` parameter is provided."

  ary = []

  spots = client.spots_by_query(params[:key])
  spots.map do |spot|
    ary << build_spot(spot)
  end

  ary.to_json
end

def client
  @client ||= GooglePlaces::Client.new(API_KEY)
end

def build_spot(spot)
  { 
    name: spot.name,
    formatted_address: spot.formatted_address,
    lat: spot.lat,
    lng: spot.lng,
    icon: spot.icon
  }
end
