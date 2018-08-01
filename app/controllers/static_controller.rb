class StaticController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: []

  def dashboard
    @user = User.find(session[:user_id])
  end

  def home
    redirect_to dashboard_path
  end
end
