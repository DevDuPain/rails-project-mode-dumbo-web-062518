class UsersController < ApplicationController
  def show
    user_id = 1 #temporary var, switch to session user_id
    @user = User.find(user_id)
    # byebug
  end
end
