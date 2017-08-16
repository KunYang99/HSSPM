class Fep::HomeController < ApplicationController
  authorize_resource :class => :fep

  layout 'fep'

  def index
    @data_cnt = Dataset.count
    @project_cnt = Project.count
    @ops_project = ['Title', 'PI', 'Members']
    @ops_data = ['Subject ID', 'Title', 'Availability', 'Contributor', 'PI', 'Note']

    @projects = Project.where('progress < 100').order(:progress)
  end
end
