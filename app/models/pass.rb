class Pass < ActiveRecord::Base
  attr_accessible :gym_id, :redemption_code, :timestamps, :user_id
end
