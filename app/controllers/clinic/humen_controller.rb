class Clinic::HumenController < ApplicationController
  authorize_resource :class => :clinic

  layout 'clinic'

  require 'csv'

  def index
    @subject_all = Human.order('accession')
    
    @filterrific = initialize_filterrific(
      @subject_all,
      params[:filterrific],
      :select_options => {
        with_status: Status.options_for_select,
        with_irb: Irb.options_for_select,
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
    @ops = ['Status', 'ID', 'IRB', 'Gender', 'Race', 'Population', 'Note']
    @key = params['key']
    @value = params['value']

    if params['key'] == 'Status'
      @subjects = Human.joins(:status).where("statuses.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'ID'
      @subjects = Human.where("accession LIKE ? OR other_ids LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    elsif params['key'] == 'IRB'
      @subjects = Human.joins(:irbs).where("irbs.name LIKE ? OR irbs.number LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
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

  def new
    @human = Human.new
    @human.build_demography
    @human.visits.build
  end

  def create
    @human = Human.new(human_params)
    params["human"]["demography_attributes"]["data"].split("\r\n").each do |item|
      if item.split(':').size != 2
        return edit_clinic_human_path(@human), :flash => {:error => 'Demographic data is in wrong format. Must put one item per line, and each item must in format key: value'}
      end
    end
    if verify_recaptcha(model: @human) && @human.save
      return redirect_to clinic_human_path(@human)
    else 
      return render :new
    end       
  end

  def edit
    @human = Human.find(params[:id])
    @human.build_demography unless @human.demography
    @human.visits.build if @human.visits.count == 0
  end

  def update
    @human = Human.find(params[:id])
    tmp = []
    params["human"]["demography_attributes"]["data"].split("\r\n").each do |item|
      if item.split(':').size != 2
        return redirect_to edit_clinic_human_path(@human), :flash => {:error => 'Demographic data is in wrong format. Must put one item per line, and each item must in format key: value'}
      end
    end
    if verify_recaptcha(model: @human) && @human.update_attributes(human_params)
      redirect_to clinic_human_path(@human)
    else
      render :edit
    end

  end

  private

  def human_params
    params.require(:human).permit!
  end   


 
end
