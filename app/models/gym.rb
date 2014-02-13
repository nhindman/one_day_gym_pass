class Gym < ActiveRecord::Base
  attr_accessible :address, :cross_street, :name, :phone_number, :image_url, :snippet_text, :distance, :url, :business_id
end
