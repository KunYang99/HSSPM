class Admin::ProjectsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if verify_recaptcha(model: @project) && @project.save
      return redirect_to admin_projects_path, notice: 'New project added!'
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
      redirect_to admin_projects_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit!
  end   

end
