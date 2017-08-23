class Clinic::IrbsController < ApplicationController
  authorize_resource :class => :clinic

  layout 'clinic'

  def index
    @irbs = Irb.all
  end

  def show
    @irb = Irb.find(params[:id])
    
    @filterrific = initialize_filterrific(
      @irb.humen,
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
        headers['Content-Disposition'] = "attachment; filename=human_subjects_of_#{@irb.number}.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new
    @irb = Irb.new
  end

  def create
    @irb = Irb.new(irb_params)
    if verify_recaptcha(model: @irb) && @irb.save
      return redirect_to clinic_irbs_path
    else 
      return render :new
    end       
  end

  def edit
    @irb = Irb.find(params[:id])
  end

  def update
    @irb = Irb.find(params[:id])

    if verify_recaptcha(model: @irb) && @irb.update_attributes(irb_params)
      redirect_to clinic_irbs_path
    else
      render :edit
    end

  end

  private

  def irb_params
    params.require(:irb).permit!
  end   

end
