class Admin::PopulationsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @populations = Population.all
  end

  def new
    @population = Population.new
  end

  def create
    @population = Population.new(population_params)
    if verify_recaptcha(model: @population) && @population.save
      return redirect_to admin_populations_path, notice: 'New population added!'
    else 
      return render :new
    end       
  end

  def edit
    @population = Population.find(params[:id])
  end

  def update
    @population = Population.find(params[:id])

    if verify_recaptcha(model: @population) && @population.update_attributes(population_params)
      redirect_to admin_populations_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def population_params
    params.require(:population).permit!
  end   

end
