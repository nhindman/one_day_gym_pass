class PassesController < ApplicationController

def new
  # redirect_to root_path
end

def index
  user_input_address = params[:user_input_address]
  @gyms_near_address = user_input_address.split.map(&:capitalize).join(' ')
  user_address = user_input_address.gsub(" ", '%20')
  # binding.pry
  address = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{user_address}&sensor=true")
  lat = address["results"][0]["geometry"]["location"]["lat"]
  lng = address["results"][0]["geometry"]["location"]["lng"]
  venue_search = HTTParty.get("https://api.foursquare.com/v2/venues/search?categoryId=4bf58dd8d48988d175941735&ll=#{lat},#{lng}&client_id=YRXH0LHSXPSQQPQA34I41XKQCUNAVQIF0TTNXWXQC0NUZJGD&client_secret=ENUT2HBL3TARDIIF4RMLE05WLVX0FVPN452E3OMJWJEX3D1T")
  @items = venue_search["response"]["groups"][0]["items"]
  # @items = Item.all
  # redirect_to passes_path
  render :'passes/index'
end

def show
  venue = params
  venue_id = venue["id"]
  #send venue id here
  response = HTTParty.get("https://api.foursquare.com/v2/venues/#{venue_id}?client_id=YRXH0LHSXPSQQPQA34I41XKQCUNAVQIF0TTNXWXQC0NUZJGD&client_secret=ENUT2HBL3TARDIIF4RMLE05WLVX0FVPN452E3OMJWJEX3D1T")
  gym = JSON.parse(response.body)
  @gym_name = gym["response"]["venue"]["name"]
  @phone_number = gym["response"]["venue"]["contact"]["formattedPhone"]
  @address = gym["response"]["venue"]["location"]["address"]
  @cross_street = gym["response"]["venue"]["location"]["crossStreet"]
  @city = gym["response"]["venue"]["location"]["city"]
  @state = gym["response"]["venue"]["location"]["state"]
  @postal_code = gym["response"]["venue"]["location"]["postalCode"]
  @website = gym["response"]["venue"]["url"]
  @description = gym["response"]["venue"]["description"]
  # @photos = gym["response"]["venue"]["photos"]
  # binding.pry
  #example request
  #"https://api.foursquare.com/v2/venues/4b522afaf964a5200b6d27e3?client_id=CLIENT_ID&client_secret=CLIENT_SECRET
  #https://foursquare.com/v/equinox/4a2f3322f964a520b6981fe3
  render new_pass_path
end

def create
  render :text => "Hello World"
end

end


