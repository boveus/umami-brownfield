class PasswordController < ApplicationController
  def index
  end
  
  def show
    user = User.find_by(params["user"]["email"])
  end

end