class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :is_valid_session?

  def create
    if params[:sessions]
      user = User.find_by_username(params[:sessions][:username])
      if user.nil?
        flash[:error] = "Username not found. Please check."
        return redirect_to root_url
      elsif user.member?('disabled')
        flash[:error] = "Sorry, you account is disabled."
        return redirect_to root_url
      elsif user.authenticate(params[:sessions][:password])
        session[:user_id] = user.id
        redirect_to root_url
      else
        flash[:error] = "Wrong password"
        return redirect_to root_url
      end
    else
      auth = request.env['omniauth.auth']    
      user = User.find_by_gmail(auth[:info][:email])
      if user.nil?
        flash[:error] = "Sorry, only registered users can use this website."
        return redirect_to root_url
      end
      if user.member?('disabled')
        flash[:error] = "Sorry, you account is disabled."
        return redirect_to root_url
      end
      session[:user_id] = user.id
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def failure
    flash[:error] = "Something goes wrong: #{params[:message]}"
    redirect_to root_url
  end

end
