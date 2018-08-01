class UsersController < ApplicationController

  def show
    user_id = 1 #temporary var, switch to session user_id
    @user = User.find(user_id)
    # byebug
  end

  def edit
    user_id = 1 #temporary var, switch to session user_id
    @user = User.find(user_id)
  end

  def update
    user_id = 1 #temporary var, switch to session user_id
    @user = User.find(user_id)

    if @user.update
      redirect_to profile_path
    else
      render :edit
    end
  end
end
