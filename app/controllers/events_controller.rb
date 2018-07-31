class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def create
    byebug
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
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
    params.require(:event).permit(:owner_id, :name, :description, :date, :location_id, :required_rank)
  end
end
