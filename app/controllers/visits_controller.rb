class VisitsController < ApplicationController

  def new
    @stores = Store.all
    @visit = Visit.new
  end

  def create
    code = Token.find_by(visit_params[:store_id])
    if code.nil?
      flash[:alert] = "A code has not yet been created for this store today."
      redirect_to new_visit_path
    elsif visit_params[:code].downcase != code[:code].downcase
      flash[:alert] = "The code you have entered is not correct. Please retrieve the correct code for this store."
      redirect_to new_visit_path
    else
      @visit = Visit.create(customer_id: current_user.id, store_id: visit_params[:store_id], position: position(visit_params[:store_id]), start_time: Time.now, status: "queued") 
      redirect_to visit_path(@visit.id)
    end
  end

  def show
    @visit = Visit.find_by(id: params[:id])
  end

  private


  def visit_params
    params.require(:visit).permit(:code, :store_id)
  end

  def position(store_id)
    Visit.select{ |visit| visit.store_id == store_id && visit.date == Date.today}.count + 1
  end

end