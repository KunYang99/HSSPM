class Admin::UsersController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @admin = User.admin
    @sample_users = User.sample_db
    @clinic_users = User.clinic
    @fep_users = User.fep
    @disabled = User.disabled
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      return redirect_to admin_users_path, notice: 'New member added!'
    else 
      return render :new
    end       
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if verify_recaptcha(model: @user) && @user.update_attributes(user_params)
      redirect_to admin_users_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :gmail, :username, :password, :password_confirm, :email, group_ids: [])
  end   

end
