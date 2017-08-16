class Fep::DatasetsController < ApplicationController
  authorize_resource :class => :fep

  layout 'fep'

  def index
   
    @dataset_all = Dataset.all

    @filterrific = initialize_filterrific(
      @dataset_all.order('human_id'),
      params[:filterrific],
      :select_options => {
        with_project: Project.options_for_select,
      }
    ) or return
    @datasets = @filterrific.find.page(params[:page])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_results
    @ops = ['Subject ID', 'Title', 'Availability', 'Contributor', 'PI', 'Note']
    if params['key'] == 'Subject ID'
      @datasets = Dataset.joins(:human).where("humen.accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Title'
      @datasets = Dataset.where("title LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Availability'
      @datasets = Dataset.where("availability LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Contributor'
      @datasets = Dataset.where("contributors LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'PI'
      @datasets = Dataset.where("pi LIKE ?", "%%#{params['value']}%%")
    else
      @datasets = Dataset.where("note LIKE ?", "%%#{params['value']}%%")
    end
  end

end
