class Admin::GroupsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if verify_recaptcha(model: @group) && @group.save
      return redirect_to admin_groups_path, notice: 'New group added!'
    else 
      return render :new
    end       
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if verify_recaptcha(model: @group) && @group.update_attributes(group_params)
      redirect_to admin_groups_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def group_params
    params.require(:group).permit!
  end   

end
