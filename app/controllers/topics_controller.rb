class TopicsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  def index
    @topics = model.all
  end

  def show
    @topic = model.find(params[:id])
  end

  def edit
    @topic = model.find(params[:id])
  end

  def update
    @topic = model.find(params[:id])
    @topic.update_attributes(params[:topic].permit(:name))
    redirect_to topic_path(@topic)
  end

  def destroy
    @topic = model.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  def model
    Topic
  end
end
