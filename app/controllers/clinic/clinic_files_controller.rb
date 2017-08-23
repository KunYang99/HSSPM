class Clinic::ClinicFilesController < ApplicationController
  authorize_resource :class => :clinic
  layout 'clinic'

  def index
    @clinic_files = ClinicFile.all
  end

  def new
    @clinic_file = ClinicFile.new
  end

  def create
    @clinic_file = ClinicFile.new(clinic_file_params)
    if verify_recaptcha(model: @clinic_file) && @clinic_file.save
      return redirect_to clinic_clinic_files_path
    else 
      return render :new
    end       
  end

  def edit
    @clinic_file = ClinicFile.find(params[:id])
  end

  def update
    @clinic_file = ClinicFile.find(params[:id])

    if verify_recaptcha(model: @clinic_file) && @clinic_file.update_attributes(clinic_file_params)
      redirect_to clinic_clinic_files_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @clinic_file = ClinicFile.find(params[:id])
    @clinic_file.remove_file!

    if @clinic_file.destroy
      redirect_to clinic_clinic_files_path
    else
      redirect_to clinic_clinic_files_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  private

  def clinic_file_params
    params.require(:clinic_file).permit!
  end   

end
