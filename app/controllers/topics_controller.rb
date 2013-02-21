class TopicsController < ApplicationController
  respond_to :html, :json

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.recent.decorate
    respond_with @topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id]).decorate
    respond_with @topic
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = current_user.submitted_topics.build.decorate
    respond_with @topic
  end

  # GET /topics/1/edit
  def edit
    @topic = current_user.editable_topics.find(params[:id]).decorate
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.submitted_topics.build(params[:topic]).decorate
    @topic.save
    respond_with @topic
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = current_user.editable_topics.find(params[:id]).decorate
    @topic.update_attributes(params[:topic])
    respond_with @topic
  end

  # PUT /topics/1/claim
  # PUT /topics/1/claim.json
  def claim
    @topic = current_user.claimable_topics.find(params[:id]).decorate
    @topic.speaker = current_user
    @topic.save
    respond_with @topic
  end

  # PUT /topics/1/unclaim
  # PUT /topics/1/unclaim.json
  def unclaim
    @topic = current_user.speeches.find(params[:id]).decorate
    @topic.speaker = nil
    @topic.save
    respond_with @topic
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = current_user.editable_topics.find(params[:id]).decorate
    @topic.destroy
    respond_with @topic
  end
end
