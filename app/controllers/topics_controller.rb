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
    if @topic.update_attributes(params[:topic].permit(:name))
      redirect_to topic_url(@topic)
    else
      render :edit
    end
  end

  def model
    Topic
  end
end
