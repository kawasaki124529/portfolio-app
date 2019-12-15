# frozen_string_literal: true

class Api::CommentsController < ApplicationController
  def index
    @comments = Comment.find_by(topic_id: params[:topic_id])
    render json: @comments, status: 200
  end

  def create
    @comment = Comment.new
    @comment.user_id = params[:user_id]
    @comment.topic_id = params[:topic_id]
    @comment.content = params[:content]
    @topic = Topic.find_by(id: params[:topic_id])
    if @comment.save
      render json:
        @topic,
             status: 200
    else
      render json: {
        status: 400
      }
    end
  end
end
