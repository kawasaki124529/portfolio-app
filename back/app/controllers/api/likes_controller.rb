class Api::LikesController < ApplicationController

  def create
    @like = Like.new
    @like.user_id = params[:user_id]
    @like.topic_id = params[:topic_id]
    @topic = Topic.find_by(id: params[:topic_id])
    if @like.save
      render json: 
        @topic,
        status: 200
    else
      render json: {
        status: 400
      }
    end
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], topic_id: params[:topic_id])
    @topic = Topic.find_by(id: params[:topic_id])
    if @like.destroy
      render json: 
        @topic,
        status: 201
    else
      render json: {
        status: 401
      }
    end
  end
end
