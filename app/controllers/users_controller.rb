class UsersController < ApplicationController


  def new
  end


  def index
 
  end

  def you_are_signed_in
    # blocks non signed in users from seeing this page
    if current_user 
      render json: { 
        user: current_user,
        session: user_session
      }
    else 
      redirect_to root_path
    end
  end

end