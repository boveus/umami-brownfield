module Users
  class PasswordController < ApplicationController
   before_action :authenticated?, only: [:edit, :update]
 
   def edit
     if current_user
       @user = current_user
     else
       @user = User.find(params["format"])
     end
   end
 
   def reset
     if current_user
       ConfirmationSender.send_confirmation_to(current_user)
     elsif params
       @user = User.find(params["format"])
       ConfirmationSender.send_confirmation_to(@user)
      #  redirect_to controller: '/users/password', action: ''
       redirect_to new_confirmation_path(@user)
     end
   end
 
   def update
     @user = User.find_by(name: params[:format])
     if passwords_not_empty? && passwords_equal?
       @user.update(password_params)
       redirect_to root_path, success: "Password Updated"
       session[:authenticated] = false
     else
       redirect_to users_password_edit_path(current_user.username), warning: "Error, please try again."
     end
   end
 
   private
 
   def authenticated?
     render :file => "#{Rails.root}/public/404.html", :status => 404 unless session[:authenticated]
   end
 
   def password_params
     params.require(:user).permit(:password, :password_confirmation)
   end
 
   def passwords_not_empty?
     params[:user][:password].length > 0 && params[:user][:password_confirmation].length > 0
   end
 
   def passwords_equal?
     params[:user][:password] == params[:user][:password_confirmation]
   end
 end
end
