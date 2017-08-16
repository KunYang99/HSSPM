class Fep::ProjectsController < ApplicationController
  authorize_resource :class => :fep
  layout 'fep'

  def index
    @projects_ongoing = Project.where("progress < 100").order(:progress)
    @projects_finished = Project.where('progress = 100').order(:name)
  end

  def show
    @project = Project.find(params[:id])
    @dataset_all = @project.datasets
    
    @filterrific = initialize_filterrific(
      @dataset_all.order('human_id'),
      params[:filterrific]
    ) or return
    @datasets = @filterrific.find.page(params[:page])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_results
    if params['key'] == 'Title'
      @projects = Project.where("name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'PI'
      @projects = Project.where("PI LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Members'
      @projects = Project.where("members LIKE ?", "%%#{params['value']}%%")
    end
  end
end
