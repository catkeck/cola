class CashRegistersController < ApplicationController
  
  def new
    @cash_register = CashRegister.new
  end

  def create
    @cash_register = CashRegister.new(cash_register_params)
    if @cash_register.save
      redirect_to store_path(cash_register_params[:store_id])
    else
      render :new
    end
  end

  def show
    @cash_register = CashRegister.find_by(id: params[:id])
  end

  private

    def cash_register_params
      params.require(:cash_register).permit(:register_number, :store_id)
    end
end