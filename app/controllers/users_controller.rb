class UsersController < ApplicationController
  def show
    user_id = 1 # temporary var, get session user_id later
    @user = User.find(user_id)

  end
end
