class Admin::RacesController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @races = Race.all
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    if verify_recaptcha(model: @race) && @race.save
      return redirect_to admin_races_path, notice: 'New race added!'
    else 
      return render :new
    end       
  end

  def edit
    @race = Race.find(params[:id])
  end

  def update
    @race = Race.find(params[:id])

    if verify_recaptcha(model: @race) && @race.update_attributes(race_params)
      redirect_to admin_races_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def race_params
    params.require(:race).permit!
  end   

end
