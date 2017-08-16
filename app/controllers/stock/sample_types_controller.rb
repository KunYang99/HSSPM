class Stock::SampleTypesController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def show
    @sample_type = SampleType.find(params[:id])
    @samples = HumanSample.joins(:sample_type).where(:sample_types => {:id => params[:id]}).order('accession')
    @human_cnt = @samples.joins(:visit => :human).pluck("humen.accession").uniq.count
    @main_loc = @samples.joins(:main_location).pluck("main_locations.name").uniq
    
    @filterrific = initialize_filterrific(
      @samples,
      params[:filterrific],
      :select_options => {
        with_location: MainLocation.options_for_select
      }
    ) or return
    @human_samples = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=samples_#{@sample_type.name}.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

end
