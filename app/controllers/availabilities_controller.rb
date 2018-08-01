class AvailabilitiesController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: []
end
