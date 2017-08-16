class Stock::DatasetsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
    @filterrific = initialize_filterrific(
      Dataset.order('human_id'),
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

end
