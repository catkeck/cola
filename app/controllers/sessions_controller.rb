class SessionsController < ApplicationController

  def admin_new
    @access = "admin"
    render 'login'
  end

  def admin_create
    user_create("admin")
  end

  def customer_new
    @access = "customer"
    render 'login'
  end

  def customer_create
    user_create("customer")
  end

  def cashier_new
    @access = "cashier"
    render 'login'
  end

  def cashier_create
    user_create("cashier")
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

    def user_create(user_type)
      @user = User.find_by(username: params[:user][:username])
      if !@user.nil?
        return redirect_to "/#{user_type}s/login" unless @user.authenticate(params[:user][:password])
        if @user.send("is_#{user_type}?")
          session[:id] = @user.id
          redirect_to "/#{user_type}s/#{@user.id}/"
        else
          @access = user_type
          render "login"
        end
      else
        @access = user_type
        render "login"
      end
    end
end

