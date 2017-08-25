class Admin::ProjectsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if verify_recaptcha(model: @project) && @project.save
      return redirect_to admin_project_path(@project)
    else 
      return render :new
    end       
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if verify_recaptcha(model: @project) && @project.update_attributes(project_params)
      redirect_to admin_project_path(@project)
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit!
  end   

end
