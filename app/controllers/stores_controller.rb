  class StoresController < ApplicationController

  def new
    if !current_user.is_admin?
      flash[:alert] = "You can not create a store unless you are an admin"
      redirect_to "/"
    else
      @store = Store.new
    end
  end

  def create
    if !current_user.is_admin?
      flash[:alert] = "You can not create a store unless you are an admin"
      redirect_to "/"
    else
      @store = Store.new(store_params)
      @store.admin_id = current_user.id
      if @store.save
        redirect_to store_path(@store.id)
      else
        render :new
      end
    end
  end

  def show
    @store = Store.find(params[:id])
    if current_user.is_admin?
      render :show
    else
      render :show_customer
    end
  end

  def charts
    store = Store.find(params[:id])

    visits_per_cashier_rows = store.visits.where("status = 'served'").group(:cashier_id).count
    @visits_per_cashier = visits_per_cashier_rows.map do |cashier_id, value|
      [User.find_by(id: cashier_id).name, value]
    end

    visits_per_day_rows = store.visits.where("status = 'served'").group("strftime('%w', end_time)").count
    @visits_per_day = visits_per_day_rows.map do |day, value|
      [Date::ABBR_DAYNAMES[day.to_i], value]
    end

    waittime_per_day_rows = store.visits.where("status = 'served'").group("strftime('%w', end_time)").average("(julianday(checkout_time) - julianday(start_time)) * 24 * 60")
    @waittime_per_day = waittime_per_day_rows.map do |day, value|
      [Date::ABBR_DAYNAMES[day.to_i], value]
    end

    serve_time_per_day_rows = store.visits.where("status = 'served'").group(:cashier_id).average("(julianday(end_time) - julianday(checkout_time)) * 24 * 60")
    @serve_time_per_day = serve_time_per_day_rows.map do |cashier_id, value|
      [User.find_by(id: cashier_id).name, value]
    end
  end

  def index
    if params[:latitude].present? && params[:longitude].present?
      @stores = Store.all.near([params[:latitude], params[:longitude]], 10)
    elsif params[:search].present?
      @stores = Store.search(params[:search])
    else
      @stores = Store.all
    end
    if current_user.is_admin?
      @stores = find_admin_stores(@stores)
    end
    @locations = @stores.map{|store| {lat: store.latitude, lng: store.longitude}}.to_json
    @stores = @stores.sort_by{|store| store.name}
  end

  def update
    if @store.admin != current_user
      flash[:alert] = "You can not update stores that you are not the admin of."
      redirect_to "/"
    end
  end

  def token
    @store = Store.find(params[:id])
    @token = Token.find_or_create(@store.id)
  end
  
  private

  def store_params
    params.require(:store).permit(:name, :address, :image)
  end

  def find_admin_stores(stores)
    stores.select{ |store| store.admin == current_user}
  end

end