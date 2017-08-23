class Stock::HumanSamplesController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  require 'csv'

  def index

    @sample_all = HumanSample.order('accession')
    
    @filterrific = initialize_filterrific(
      @sample_all,
      params[:filterrific],
      :select_options => {
        with_type: SampleType.options_for_select,
        with_location: MainLocation.options_for_select
      }
    ) or return
    @human_samples = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=human_samples.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
    @sample = HumanSample.find(params[:id])
  end

  def search_results
    @ops = ['Sample ID', 'Type', 'Subject ID', 'Visit', 'Main Location', 'Note']
    @key = params['key']
    @value = params['value']

    if params['key'] == 'Sample ID'
      @samples = HumanSample.where("accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Type'
      @samples = HumanSample.joins(:sample_type).where("sample_types.name LIKE ? or sample_types.note LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    elsif params['key'] == 'Subject ID'
      @samples = HumanSample.joins(:visit => :human).where("humen.accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Visit'
      @samples = HumanSample.joins(:visit => :visit_type).where("visit_types.value LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == "Main Location"
      @samples = HumanSample.joins(:main_location).where("main_locations.name LIKE ? OR main_locations.location LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    else
      @samples = HumanSample.where("note LIKE ?", "%%#{params['value']}%%")
    end

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=human_sample_search_results.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def batch_search
  end

  def batch_search_results
    @value = params['subjects']
    @key = params['type']

    @samples = []
    params['subjects'].split("\r\n").each do |sub|
      sub.strip!
      @samples += HumanSample.joins(:visit => :human).where("(humen.accession LIKE ? OR humen.other_ids LIKE ?) AND human_samples.sample_type_id = ?", sub, "%%#{sub}%%", params['type'])
    end
    
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=human_sample_search_results.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
end
