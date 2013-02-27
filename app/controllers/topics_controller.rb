require 'digest'

class TopicsController < ApplicationController
  respond_to :html, :json

  before_filter :require_authentication!, except: [:index, :show]
  before_filter :force_updated_user_profile!

  def index
    @topics = Topic.sorted.decorate
    respond_with @topics
  end

  def show
    @topic = Topic.find(params[:id]).decorate
    respond_with @topic
  end

  def new
    @topic = current_user.submitted_topics.build.decorate
    respond_with @topic
  end

  def edit
    @topic = current_user.editable_topics.find(params[:id]).decorate
  end

  def create
    @topic = current_user.submitted_topics.build(params[:topic]).decorate
    @topic.save
    respond_with @topic
  end

  def update
    @topic = current_user.editable_topics.find(params[:id]).decorate
    @topic.update_attributes(params[:topic])
    respond_with @topic
  end

  def claim
    if current_user.speeches.count < 2
      @topic = current_user.claimable_topics.find(params[:id]).decorate
      @topic.speaker = current_user
      @topic.save
    else
      flash[:alert] = 'You cannot volunteer for more than 2 topics at a time. You can unclaim less desirable topics if you wish to switch to this topic.'
    end
    redirect_to root_path
  end

  def unclaim
    @topic = current_user.speeches.find(params[:id]).decorate
    @topic.speaker = nil
    @topic.save
    redirect_to root_path
  end

  def schedule
    @topics = Topic.claimed.decorate.sort_by{|topic| Digest::SHA1.hexdigest(Date.today.to_s + topic.id.to_s) }
    respond_with @topics
  end

  def destroy
    @topic = current_user.editable_topics.find(params[:id]).decorate
    @topic.destroy
    respond_with @topic
  end
end
