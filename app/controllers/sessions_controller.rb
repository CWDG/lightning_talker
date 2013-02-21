class SessionsController < ApplicationController
  respond_to :html, :json

  def new
    @user = User.new.decorate
    respond_with @user
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed in successfully.'
    else
      @username = params[:username]
      flash[:alert] = "Username/password did not match our records. Please check your credentials and try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Signed out.'
  end

end
