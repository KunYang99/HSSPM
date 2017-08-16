class Admin::MaterialsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    if verify_recaptcha(model: @material) && @material.save
      return redirect_to admin_materials_path, notice: 'New material added!'
    else 
      return render :new
    end       
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    if verify_recaptcha(model: @material) && @material.update_attributes(material_params)
      redirect_to admin_materials_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @material = Material.find(params[:id])
    @material.remove_file!

    if @material.destroy
      redirect_to admin_materials_path, :notice => "Material deleted!"
    else
      redirect_to admin_materials_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  private

  def material_params
    params.require(:material).permit!
  end   

end
