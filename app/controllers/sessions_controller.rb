class SessionsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @errors = ""
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      @errors << "Your password and username combination do not match"
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end
end
