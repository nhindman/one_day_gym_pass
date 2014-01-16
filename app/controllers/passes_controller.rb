# require 'rubygems'
# require 'oauth'

class PassesController < ApplicationController

def new 
  if current_user  
  @gym = Gym.create({
    name: params[:gym_name],
    address: params[:address],
    cross_street: params[:cross_street],
    phone_number: params[:phone_number]
    })
  @pass = Pass.create({
    user_id: current_user.id,
    gym_id: @gym.id, 
    redemption_code: rand.to_s[5..9]
    })
  render :'passes/show'
  else 
  render :'passes/need_auth'
end
end

def index
  user_input_address = params[:user_input_address]
  @gyms_near_address = user_input_address.split.map(&:capitalize).join(' ')
  user_address = user_input_address.gsub(" ", '%20')
  # binding.pry
  thing = "http://maps.googleapis.com/maps/api/geocode/json?address=#{user_address}&sensor=true"
  address = HTTParty.get(thing)
  # binding.pry
  lat = address["results"][0]["geometry"]["location"]["lat"]
  lng = address["results"][0]["geometry"]["location"]["lng"]
  #yelp venue search:
  api_host = 'api.yelp.com'
  consumer_key = 'iW5_ThIyVR3ftusDd-qHVw'
  consumer_secret = 'sBQoF_oIEJ4g3_tZyTXPFJdA-6Y'
  token = 'Ba221Wynsy_cKXZVFUCMzH8qXYbsYJq8'
  token_secret = 'GXdHVOG8J9lgiTXq34BLoBEmrDg'

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)
  path = "/v2/search?term=gym&ll=#{lat},#{lng}"
  result = access_token.get(path).body
  results = JSON(result)
  @businesses = results["businesses"]
  # foursquare venue search:
  # venue_search = HTTParty.get("https://api.foursquare.com/v2/venues/search?categoryId=4bf58dd8d48988d175941735&ll=#{lat},#{lng}&client_id=YRXH0LHSXPSQQPQA34I41XKQCUNAVQIF0TTNXWXQC0NUZJGD&client_secret=ENUT2HBL3TARDIIF4RMLE05WLVX0FVPN452E3OMJWJEX3D1T")
  # @items = venue_search["response"]["groups"][0]["items"]
  # @items = Item.all
  # redirect_to passes_path
  # binding.pry
  render :'passes/index'
end

def show
  venue = params
  venue_id = venue["id"]
  #send venue id here
  api_host = 'api.yelp.com'
  consumer_key = 'iW5_ThIyVR3ftusDd-qHVw'
  consumer_secret = 'sBQoF_oIEJ4g3_tZyTXPFJdA-6Y'
  token = 'Ba221Wynsy_cKXZVFUCMzH8qXYbsYJq8'
  token_secret = 'GXdHVOG8J9lgiTXq34BLoBEmrDg'

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)
  path = "/v2/business/#{venue_id}"
  result = access_token.get(path).body
  gym = JSON(result)
  @gym_name = gym["name"]
  @gym_image = gym["image_url"]
  @gym_url = gym["url"]
  @gym_review = gym["reviews"][0]["excerpt"]
  @gym_phone = gym["phone"]
  @gym_address = gym["location"]["display_address"].join(" ").gsub("["," ")

  @gym_map_address = @gym_address.gsub('%20'," ")
  puts "looking for address" 
  puts @gym_map_address
  results = Geocoder.search(@gym_map_address) 
  @lat = results[0].data["geometry"]["location"]["lat"]
  @lng = results[0].data["geometry"]["location"]["lng"]
  # thing = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@gym_map_address}&sensor=true"
  # address = HTTParty.get(thing)
  # # binding.pry
  # puts "checking latitude"
  # @lat = address["results"][0]["geometry"]["location"]["lat"].round(6)
  # puts "checking latitude"
  # puts @lat
  # @lng = address["results"][0]["geometry"]["location"]["lng"].round(6)

  #hash[0].data["geometry"]["location"]["lat"]
  #hash[0].data["geometry"]["location"]["lng"]
  # old foursquare api code
  # response = HTTParty.get("https://api.foursquare.com/v2/venues/#{venue_id}?client_id=YRXH0LHSXPSQQPQA34I41XKQCUNAVQIF0TTNXWXQC0NUZJGD&client_secret=ENUT2HBL3TARDIIF4RMLE05WLVX0FVPN452E3OMJWJEX3D1T")
  # gym = JSON.parse(response.body)
  # @gym_name = gym["response"]["venue"]["name"]
  # @phone_number = gym["response"]["venue"]["contact"]["formattedPhone"]
  # @address = gym["response"]["venue"]["location"]["address"]
  # @cross_street = gym["response"]["venue"]["location"]["crossStreet"]
  # @city = gym["response"]["venue"]["location"]["city"]
  # @state = gym["response"]["venue"]["location"]["state"]
  # @postal_code = gym["response"]["venue"]["location"]["postalCode"]
  # @website = gym["response"]["venue"]["url"]
  # @description = gym["response"]["venue"]["description"]
  # #example request
  #"https://api.foursquare.com/v2/venues/4b522afaf964a5200b6d27e3?client_id=CLIENT_ID&client_secret=CLIENT_SECRET
  #https://foursquare.com/v/equinox/4a2f3322f964a520b6981fe3
  render new_pass_path
end

def create
  render :text => "Hello World"
end

end


