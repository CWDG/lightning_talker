class UsersController < ApplicationController
  respond_to :html, :json

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
    respond_with @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user]).decorate
    @user.save
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id]).decorate
    @user.update_attributes(params[:user])
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id]).decorate
    @user.destroy
    respond_with @user
  end
end