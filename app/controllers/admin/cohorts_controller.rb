class Admin::CohortsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if verify_recaptcha(model: @cohort) && @cohort.save
      return redirect_to admin_cohorts_path, notice: 'New cohort added!'
    else 
      return render :new
    end       
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])

    if verify_recaptcha(model: @cohort) && @cohort.update_attributes(cohort_params)
      redirect_to admin_cohorts_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def cohort_params
    params.require(:cohort).permit!
  end   

end
