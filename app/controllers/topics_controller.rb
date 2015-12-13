class TopicsController < ApplicationController
  def index
    @topics = model.all
  end

  def model
    Topic
  end
end
