# require 'rubygems'
# require 'oauth'

class PassesController < ApplicationController

def new 
#   if current_user  
#   @gym = Gym.create({
#     name: params[:gym_name],
#     address: params[:address],
#     cross_street: params[:cross_street],
#     phone_number: params[:phone_number]
#     })
#   @pass = Pass.create({
#     user_id: current_user.id,
#     gym_id: @gym.id, 
#     redemption_code: rand.to_s[5..9]
#     })
#   render :'passes/show'
#   else 
#   render :'passes/need_auth'
# end
end

def index
  user_input_address = params[:user_input_address]
  string = user_input_address.split.map(&:capitalize).join(' ')
  @gyms_near_address = string[0, string.index(',')]
  puts "LOOKING FOR ADDRESS"
  puts user_input_address
  user_address = user_input_address.gsub(' ','%20')

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
  render :'passes/index'
end

def show
  authenticate_user!
  venue = params
  venue_id = venue["id"]
  #send venue id here
  api_host = 'api.yelp.com'
  consumer_key = 'iW5_ThIyVR3ftusDd-qHVw'
  consumer_secret = 'sBQoF_oIEJ4g3_tZyTXPFJdA-6Y'
  token = 'Ba221Wynsy_cKXZVFUCMzH8qXYbsYJq8'
  token_secret = 'GXdHVOG8J9lgiTXq34BLoBEmrDg'
  #yelp business id search  
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
  #sending address to geocoder which is sending to google map on new_pass_path page
  @gym_map_address = @gym_address.gsub('%20'," ")
  results = Geocoder.search(@gym_map_address) 
  @lat = results[0].data["geometry"]["location"]["lat"]
  @lng = results[0].data["geometry"]["location"]["lng"]
  @user_id = current_user.id
  @user_phone_number = current_user.phone_number
  puts "NOTICE THIS"
  puts current_user
  render new_pass_path
end

def create

  if params 
    @gym = Gym.create({
      name: params[:gym_name],
      address: params[:address],
      cross_street: params[:cross_street],
      })
    @pass = Pass.create({
      user_id: params[:user_id],
      gym_id: @gym.id, 
      redemption_code: rand.to_s[5..9]
      })
    # user = params[:current_user]
    phone_number = params[:user_phone_number]
    puts "OMAR LOOKING FOR PARAMS"
    puts params
    account_sid = "AC6935b179f7b6d21168171a78e78bba15"
    auth_token = "b7202de9d880c15ebdcc3d3df5fac06e" 
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.account.messages.create(
      :from => '+17814715045',
      :to => phone_number,
      :body => @pass.redemption_code
    )
    render :'passes/show'
  else 
    render :'passes/need_auth'
  end
end

end


