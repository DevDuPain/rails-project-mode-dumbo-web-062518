class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def index
    @user = User.find(session[:user_id])
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

    if @user.update
      redirect_to profile_path
    else
      render :edit
    end
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
end
