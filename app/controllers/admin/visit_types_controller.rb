class Admin::VisitTypesController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @visit_types = VisitType.all
  end

  def new
    @visit_type = VisitType.new
  end

  def create
    @visit_type = VisitType.new(visit_type_params)
    if verify_recaptcha(model: @visit_type) && @visit_type.save
      return redirect_to admin_visit_types_path, notice: 'New visit_type added!'
    else 
      return render :new
    end       
  end

  def edit
    @visit_type = VisitType.find(params[:id])
  end

  def update
    @visit_type = VisitType.find(params[:id])

    if verify_recaptcha(model: @visit_type) && @visit_type.update_attributes(visit_type_params)
      redirect_to admin_visit_types_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def visit_type_params
    params.require(:visit_type).permit!
  end   

end
