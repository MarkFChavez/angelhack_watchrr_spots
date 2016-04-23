require 'sinatra'
require 'json'
require 'google_places'
require 'byebug'

API_KEY = 'AIzaSyCL9LZPG85foCDceeIs_pNHD4SfK8__7vk'

get "/search" do
  ary = []

  spots = client.spots_by_query(params[:key])
  spots.each do |spot|
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
    lng: spot.lng
  }
end
