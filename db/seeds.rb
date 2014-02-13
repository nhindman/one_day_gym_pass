# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

####example of seed api call from nycdata complaint app####

# Complaint.destroy_all

# seed311 = HTTParty.get("http://data.cityofnewyork.us/resource/erm2-nwe9.json"
# )
# seed311.each do |complaint|
#   Complaint.create(:descriptor => complaint["descriptor"], :address => complaint["incident_address"], :latitude => complaint["latitude"], :longitude => complaint["longitude"], :zip => complaint["incident_zip"])
# end

################

##lat and long are global vars brought over from google api call in passes controller

# Gym.destroy_all

# api_host = 'api.yelp.com'
# consumer_key = 'iW5_ThIyVR3ftusDd-qHVw'
# consumer_secret = 'sBQoF_oIEJ4g3_tZyTXPFJdA-6Y'
# token = 'Ba221Wynsy_cKXZVFUCMzH8qXYbsYJq8'
# token_secret = 'GXdHVOG8J9lgiTXq34BLoBEmrDg'

# consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
# access_token = OAuth::AccessToken.new(consumer, token, token_secret)
# path = "/v2/search?term=gym&ll=#{$lat},#{$lng}"
# result = access_token.get(path).body
# results = JSON(result)
# @businesses = results["businesses"]
# @businesses.each do |business|
#   Gym.create(name: business["name"], image_url: business["image_url"], address: business["location"]["address"][0], snippet_text: business["snippet_text"], distance: business["distance"], url: business["url"])
# end