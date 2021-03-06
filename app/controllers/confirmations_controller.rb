class ConfirmationsController < ApplicationController
  def new
    if current_user
      @user = current_user
    else
      @user = User.find(params["format"])
    end
  end
  
  def create
    unless current_user
      @user = User.find_by(user_params)
    else
       @user = current_user
    end
    if @user.verification_code == params[:verification_code]
      session[:authenticated] = true
      redirect_to users_password_edit_path(@user)
    else
      flash.now[:error] = "Verification code is incorrect."
        render :new
    end
  end
  
  
  private
  
    def user_params
      params.permit(:verification_code)
    end
      
end
