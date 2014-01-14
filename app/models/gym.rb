class Gym < ActiveRecord::Base
  attr_accessible :address, :cross_street, :name, :phone_number
end
