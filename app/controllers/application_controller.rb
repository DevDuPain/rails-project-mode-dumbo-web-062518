class ApplicationController < ActionController::Base
  before_action :require_login
  skip_before_action :require_login, only: []

  private

  def require_login
    # return head(:forbidden) unless session.include? :user_id
    redirect_to login_path unless session.include? :user_id
  end
end
