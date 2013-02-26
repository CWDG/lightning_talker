class UsersController < ApplicationController
  respond_to :html, :json

  before_filter :require_authentication!, except: [:show, :new, :create]
  before_filter :force_updated_user_profile!, except: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.scoped.decorate
    respond_with @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id]).decorate
    respond_with @user
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new.decorate
    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id]).decorate
    return if unauthorized_user!
    respond_with @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user]).decorate
    @user.save
    session[:user_id] = @user.id
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id]).decorate
    return if unauthorized_user!
    @user.update_attributes(params[:user])
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id]).decorate
    return if unauthorized_user!
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  # TODO: this isn't working quite right. I'm getting double renders, but it does block access.
  def unauthorized_user!
    if @user != current_user
      redirect_to root_path, status: :unauthorized, alert: 'You can only perform this action on your own user!'
    end
  end
end
