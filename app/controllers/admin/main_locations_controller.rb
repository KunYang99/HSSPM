class Admin::MainLocationsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @main_locations = MainLocation.all
  end

  def new
    @main_location = MainLocation.new
  end

  def create
    @main_location = MainLocation.new(main_location_params)
    if verify_recaptcha(model: @main_location) && @main_location.save
      return redirect_to admin_main_locations_path, notice: 'New main_location added!'
    else 
      return render :new
    end       
  end

  def edit
    @main_location = MainLocation.find(params[:id])
  end

  def update
    @main_location = MainLocation.find(params[:id])

    if verify_recaptcha(model: @main_location) && @main_location.update_attributes(main_location_params)
      redirect_to admin_main_locations_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def main_location_params
    params.require(:main_location).permit!
  end   

end
