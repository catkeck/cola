class AdminsController < ApplicationController

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(admin_params)
    @admin.access = "admin"
    if @admin.save
      session[:id] = @admin.id
      redirect_to admin_path(@admin.id)
    else
      render :new
    end
  end

  def show
    if params[:id].to_i != current_user.id
      flash[:alert] = "You can not view other admin pages."
      redirect_to "/"
    elsif logged_in? && current_user.is_admin? 
      @admin = current_user
    else
      flash[:alert] = "You are not logged in as an admin."
      redirect_to "/"
    end
  end

  private

  def admin_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end