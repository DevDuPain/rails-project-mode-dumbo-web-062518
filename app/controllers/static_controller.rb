class StaticController < ApplicationController
  def dashboard
    @user = User.find(1)
  end
end
