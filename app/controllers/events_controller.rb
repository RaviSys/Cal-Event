class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        @event.create_google_event(@event, current_user)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.edit_google_event(@event.google_event_id, current_user, @event)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.delete_google_event(@event.google_event_id, current_user)
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def event_calendar
  end

  def events_for_calendar
    @events = []
    Event.all.each do |event|
      @events << {
        title: event.title,
        start: event.start_date.strftime("%Y-%m-%d"), 
        start: event.end_date.strftime("%Y-%m-%d"),
        url: event_path(event)
      }
    end
    render json: @events
  end

  def add_quick_event
    @event = Event.new(event_params)
    respond_to do |format|  
      if @event.save
        @event.add_quick_google_event(@event, current_user)
        format.html { redirect_to event_calendar_events_path, notice: 'Quick Event was successfully created.' }
      end
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit!
    end
end
