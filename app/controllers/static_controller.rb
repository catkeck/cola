class StaticController < ApplicationController

  def home
    if current_user.nil? || current_user.is_admin? || current_user.is_cashier?
      render :home
    elsif current_user.is_customer?
      @visits = current_user.visits.all.select{|visit| visit.status=="queued"}
      @currently_serving = current_user.visits.find_by(status: "serving")
      if !@currently_serving
        flash[:message] = "It is your turn. Please go to register number #{@currently_serving.cashier.current_cash_register.register_number}"
      end
    #     render :home_customer
    # elsif current_user.is_admin?
    #   render :home_admin
    # elsif current_user.is_cashier?
    #   render :home_cashier
    end
  end
  
end