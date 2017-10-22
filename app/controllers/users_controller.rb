class UsersController < ApplicationController
  before_action :require_user, only: [:dashboard]

  def dashboard
    if current_user.business_manager?
      @vendor = current_user.vendor
      render :business_manager_dashboard
    else
      @popular_items = Item.by_popularity.limit(10)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.name}"
      UserNotifier.send_signup_email(@user).deliver
      # redirect_to(@user, :notice => 'User created')
      redirect_to dashboard_path
    else
      flash[:notice] = "All Fields are Required"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
     @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      flash[:notice] = "#{@user.name} profile information updated."
      redirect_to user_path(@user)
    else
      @user = User.find(current_user.id)
      render edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :image)
  end

end
