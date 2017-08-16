class Stock::VisitsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  require 'csv'

  def index
    @visit_all = Visit.order('human_id')
    
    @filterrific = initialize_filterrific(
      @visit_all,
      params[:filterrific],
      :select_options => {
        with_type: VisitType.options_for_select,
      }
    ) or return
    @visits = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=visit_log.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
end
