class Admin::SampleTypesController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @sample_types = SampleType.all
  end

  def new
    @sample_type = SampleType.new
  end

  def create
    @sample_type = SampleType.new(sample_type_params)
    if verify_recaptcha(model: @sample_type) && @sample_type.save
      return redirect_to admin_sample_types_path, notice: 'New sample_type added!'
    else 
      return render :new
    end       
  end

  def edit
    @sample_type = SampleType.find(params[:id])
  end

  def update
    @sample_type = SampleType.find(params[:id])

    if verify_recaptcha(model: @sample_type) && @sample_type.update_attributes(sample_type_params)
      redirect_to admin_sample_types_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def sample_type_params
    params.require(:sample_type).permit!
  end   

end
