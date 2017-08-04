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
    @cashier = User.new(cashier_params)
    @cashier.access = "cashier"
    if @cashier.save
      redirect_to cashiers_path
    else
      render :new
    end
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

  def index
    if !current_user.is_admin? 
      flash[:alert] = "You are not an admin so you can not view a list of cashiers."
      redirect_to '/'
    else
      @cashiers = current_user.stores.map{|store| store.cashiers}.flatten
    end
  end

  def store_queue
    
  end

  def next
    current_visit = Visit.order(:position).find_by(status: "serving", store_id: current_user.store_id)
    next_visit = Visit.order(:position).find_by(status: "queued", store_id: current_user.store_id)
    if !current_visit.nil?
      current_visit.status = "served"
      current_visit.end_time = Time.now
      current_visit.save
    end
    if next_visit.nil?
      flash[:message] = "There is no one in line currently."
    else
      customer = next_visit.customer
      flash[:message] = "You are now serving #{customer.name}"
      next_visit.cashier_id = current_user.id
      next_visit.status = "serving"
      next_visit.checkout_time = Time.now
      next_visit.save

      message = "Hello #{customer.first_name}. It\'s your turn! Please approach register #{current_user.current_cash_register.register_number}"

      flash[:alert] = NotificationsController.tts(customer.phone_number, message)
      #flash[:alert] = NotificationsController.sms(customer.phone_number, message)
    end
    redirect_to :store_queue
  end


  def close_cash_register
    current_user.close_cash_register
    redirect_to '/'
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