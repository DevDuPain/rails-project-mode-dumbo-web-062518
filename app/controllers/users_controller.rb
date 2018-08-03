class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def index
    @user = User.find(session[:user_id])
    # @users = User.all.sort_by { |user| user.last_name }
      if params[:term]
        @users = User.search_by_full_name(params[:term]).with_pg_search_highlight
      else
        @users = []
      end
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.open_schedule
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])

    if @user.update(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def toggle_value(string)
    teststring == "0" ? teststring = "1" : teststring = "0"
  end

  def availtoggle
    @user = User.find(session[:user_id])
    to_toggle = toggle_params[7..-1].split("-")
    day_to_toggle = to_toggle[0]
    time_to_toggle = to_toggle[1]
    day_value = @user.availabilities[0][day_to_toggle]
    index_to_change = User.times_array.index(time_to_toggle)
    # byebug
    number_to_change = day_value[index_to_change]
    number_to_change == "0" ? number_to_change = "1" : number_to_change = "0"
    day_value[index_to_change] = number_to_change
    @user.availabilities.update("#{day_to_toggle}" => day_value)
    
    redirect_to profile_path
  end

  def make_rank
    rank = Rank.find_by(rankee_id: rank_params[:rankee_id], ranker_id: rank_params[:ranker_id])
    if rank != nil
      rank.update(rank_params)
      redirect_to users_path
    else
      Rank.create(rank_params)
      redirect_to users_path
    end
  end

  private

  def rank_params
    params.require(:rank).permit(:rankee_id, :ranker_id, :rank)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def toggle_params
    params.require(:toggle)
  end
end
