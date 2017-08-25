class UsersController < ApplicationController
  def index
  end
  
  def edit
  end

  def edit_password
  end

  def update
    if verify_recaptcha(model: current_user) && current_user.update_attributes(user_params)
      redirect_to users_path, :notice => "Account updated."
    else
      flash[:error] = "Updating Failed! try again"
      render action: "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :username)
  end
end
