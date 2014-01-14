class UsersController < ApplicationController


  def new
  end


  def index
    user_input_address = params[:user_input_address]
    user = User.new
    user.address = user_input_address
    user.save!
    if user.address
      redirect_to passes_path
    else
      # render 'users#index'
    end
  end

end