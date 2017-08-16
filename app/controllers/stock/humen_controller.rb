class Stock::HumenController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  require 'csv'

  def index
    @subject_all = Human.order('accession')
    
    @filterrific = initialize_filterrific(
      @subject_all,
      params[:filterrific],
      :select_options => {
        with_status: Status.options_for_select,
        with_cohort: Cohort.options_for_select,
        with_population: Population.options_for_select,
        with_gender: Gender.options_for_select,
        with_race: Race.options_for_select
      }
    ) or return
    @subjects = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=human_subjects.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
    @human = Human.find(params[:id])
  end

  def search_results
    @ops = ['Status', 'ID', 'Cohort', 'Gender', 'Race', 'Population', 'Note']
    @key = params['key']
    @value = params['value']

    if params['key'] == 'Status'
      @subjects = Human.joins(:status).where("statuses.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'ID'
      @subjects = Human.where("accession LIKE ? OR other_ids LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    elsif params['key'] == 'Cohort'
      @subjects = Human.joins(:cohorts).where("cohorts.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Gender'
      @subjects = Human.joins(:gender).where("genders.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Race'
      @subjects = Human.joins(:races).where("races.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Population'
      @subjects = Human.joins(:population).where("populations.name LIKE ?", "%%#{params['value']}%%")
    else
      @subjects = Human.where("note LIKE ?", "%%#{params['value']}%%")
    end

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=human_subject_search_results.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

end
