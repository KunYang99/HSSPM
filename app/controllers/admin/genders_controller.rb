class Admin::GendersController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @genders = Gender.all
  end

  def new
    @gender = Gender.new
  end

  def create
    @gender = Gender.new(gender_params)
    if verify_recaptcha(model: @gender) && @gender.save
      return redirect_to admin_genders_path, notice: 'New gender added!'
    else 
      return render :new
    end       
  end

  def edit
    @gender = Gender.find(params[:id])
  end

  def update
    @gender = Gender.find(params[:id])

    if verify_recaptcha(model: @gender) && @gender.update_attributes(gender_params)
      redirect_to admin_genders_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def gender_params
    params.require(:gender).permit!
  end   

end
