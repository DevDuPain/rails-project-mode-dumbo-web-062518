class EventsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: []

  def index
    @events = Event.all
    byebug
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def new
    @event = Event.new
    @user = User.find(session[:user_id])
    @event.build_location
  end

  def attend
    attendee = Attendee.create(attendee_params)
    redirect_to events_path
  end

  def unattend
    byebug
    attendee = Attendee.find_by(user_id: attendee_params[:user_id], event_id: attendee_params[:event_id])
    if attendee != nil
      attendee.destroy
      redirect_to events_path
    else
      redirect_to event_path
    end
  end

  def show
    @event = Event.find(params[:id])
    #byebug
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(parmas[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to :index
  end

  private
  def event_params
    params.require(:event).permit(:owner_id, :name, :description, :date, :location_id, :required_rank,
      location_attributes: [
        :name, :address, :description
      ])
  end

  def attendee_params
    params.require(:attendee).permit(:event_id, :user_id, :interested)
  end
end
