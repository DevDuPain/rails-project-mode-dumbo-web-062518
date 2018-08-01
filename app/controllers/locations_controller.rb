class LocationsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: []
  
  def new
    @location = Location.new
  end
end
