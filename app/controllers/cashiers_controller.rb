class CashiersController < ApplicationController

  def new
    if !current_user.is_admin? 
       flash[:alert] = "You are not an admin so you can not create a new cashier."
      redirect_to '/'
    elsif current_user.stores.count == 0
      flash[:alert] = "You do not have any stores. You need to create one before you add any cashiers."
      redirect_to new_stores_path
    else
      @cashier = User.new
    end
  end

  def create
    user = User.new(cashier_params)
    user.access = "cashier"
    user.save
    session[:id] = user.id
    redirect_to cashier_path(user.id)
  end

  def show
    @user = User.find(params[:id])
    if logged_in? && current_user.is_admin? && cashier_in_store?(@user)
      @cashier = @user
    elsif params[:id].to_i != current_user.id
      flash[:alert] = "You can not view cashier pages."
      redirect_to "/"
    elsif logged_in? && current_user.is_cashier? 
      @cashier = current_user
    else
      flash[:alert] = "You are not logged in as an cashier."
      redirect_to "/"
    end
  end

  def store_queue

  end

  def next
    current_visit = Visits.find_by(status: "serving", store_id: current_user.store_id, ).order(:position)
    next_visit = Visits.find_by(status: "queued", store_id: current_user.store_id, ).order(:position)
    if !current_visit.nil?
      current_visit.status = "served"
      current_visit.save
    end
    if visit.nil?
      flash[:alert] = "There is no one in line currently."
    else
      visit.cashier_id = current_user.id
      visit.status = "serving"
      visit.save
    end
    redirect_to :store_queue
  end

  private

  def cashier_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :store_id)
  end

  def cashier_in_store?(user)
    current_user.stores.each do |store|
      store.cash_registers.each do |cash_register|
        if cash_register.cashiers.include? user
          return true
        end
      end
    end
    return false
  end
end