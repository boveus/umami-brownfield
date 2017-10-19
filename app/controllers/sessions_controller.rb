class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:provider].present?
      @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      set_session_user_id
    else
      hand_roll_login
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
  
  private
  
  def hand_roll_login
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      set_session_user_id
    elsif @user
      flash[:notice] = "Incorrect Password for #{@user.name}"
      redirect_to login_path
    else
      flash[:notice] = "Username #{params[:user][:name]} not Registered"
      redirect_to login_path
    end
  end
  
  def set_session_user_id
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.name}"
      redirect_to dashboard_path
    end
  end

end
