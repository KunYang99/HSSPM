class Stock::CohortsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def show
    @cohort = Cohort.find(params[:id])
    @subject_all = @cohort.humen.order('accession')
    @valid = @subject_all.joins(:status).where(:statuses => {:name => 'Valid'})
    @m_cnt = @valid.joins(:gender).where(:genders => {:name => 'M'}).count 
    @f_cnt = @valid.joins(:gender).where(:genders => {:name => 'F'}).count
    @con_cnt = @valid.joins(:population).where(:populations => {:name => 'Control'}).count 
    @sz_cnt = @valid.joins(:population).where(:populations => {:name => 'SZ'}).count 
    @bp_cnt = @valid.joins(:population).where(:populations => {:name => 'BP'}).count 

    @filterrific = initialize_filterrific(
      @subject_all,
      params[:filterrific],
      :select_options => {
        with_status: Status.options_for_select,
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
        headers['Content-Disposition'] = "attachment; filename=#{@cohort.name}.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

end
