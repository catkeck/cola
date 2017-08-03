class CashierCashRegistersController < ApplicationController

  def new
    if verify_viewer
      @cashier_cash_register = CashierCashRegister.new
      @cash_registers = CashRegister.all.select{ |cash_register| cash_register.store == current_user.store}.sort_by{|cash_register| cash_register.register_number}
    end
  end

  #This is where the cashier states that they are going to a different cash register
  def create
    if verify_viewer
      cashier = current_user
      cash_register =  CashRegister.find_by(id: cashier_cash_register_params[:cash_register_id])
      close_assigned_ccrs
      @cashier_cash_register = CashierCashRegister.new(cashier_id: cashier.id, cash_register_id: cash_register.id, date: Date.today, status: true)
      if @cashier_cash_register.save
        redirect_to store_queue_path
      else
        render :new
      end
    end
  end

  private

    def cashier_cash_register_params
      params.require(:cashier_cash_register).permit(:cash_register_id)
    end

    def close_assigned_ccrs
      assigned_ccr = current_user.cashier_cash_registers.select { |ccr| ccr.status == true}
      if assigned_ccr
        assigned_ccr.each do |ccr|
          ccr.close
        end
      end
    end

    def verify_viewer
      cash_registers = CashRegister.all.select{ |cash_register| cash_register.store == current_user.store}
      if !current_user.is_cashier?
        flash[:alert] = "Sorry, you must be a cashier to select a cash register"
        redirect_to '/'
        false
      elsif cash_registers.empty?
        flash[:alert] = "There are no cash registers to work with right now."
        redirect_to '/'
        false
      else
        true
      end
    end

end