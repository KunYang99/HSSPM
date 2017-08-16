class Admin::StatusesController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @statuses = Status.all
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if verify_recaptcha(model: @status) && @status.save
      return redirect_to admin_statuses_path, notice: 'New status added!'
    else 
      return render :new
    end       
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])

    if verify_recaptcha(model: @status) && @status.update_attributes(status_params)
      redirect_to admin_statuses_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def status_params
    params.require(:status).permit!
  end   

end
