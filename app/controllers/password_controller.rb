class PasswordController < ApplicationController
  def index
    # binding.pry
  end
  
  def new
    @user = User.find_by(email: params["user"]["email"])
    unless @user
      flash[:notice] = "Unable to find User with that e-mail"
      redirect_to 'password#index'
    else
      redirect_to users_password_reset_path(@user)
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name)
    end
      
end