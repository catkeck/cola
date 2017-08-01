class CustomersController < ApplicationController

  def new
    @customer = User.new
  end

  def create
    @customer = User.new(customer_params)
    @customer.access = "customer"
    if @customer.save
      session[:id] = @customer.id
      redirect_to customer_path(@customer.id)
    else
      render :new
    end
  end

  def show
    if params[:id].to_i != current_user.id
      flash[:alert] = "You can not view other customer pages."
      redirect_to "/"
    elsif logged_in? && current_user.is_customer? 
      @customer = current_user
    else
      flash[:alert] = "You are not logged in as an customer."
      redirect_to "/"
    end
  end


  private

  def customer_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

end