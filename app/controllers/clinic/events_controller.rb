class Clinic::EventsController < ApplicationController
  authorize_resource :class => :clinic

  layout 'clinic'

  def index
    @events = Event.all
    @events_by_date = @events.group_by {|x| x.start.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if verify_recaptcha(model: @event) && @event.save
      return redirect_to clinic_event_path(@event)
    else 
      return render :new
    end       
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if verify_recaptcha(model: @event) && @event.update_attributes(event_params)
      redirect_to clinic_event_path(@event), :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to clinic_events_path, :notice => "Event deleted!"
    else
      redirect_to clinic_events_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  private

  def event_params
    params.require(:event).permit!
  end   

end
