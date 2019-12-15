module Api
  class TopicsController < ApplicationController

    def index
      @topics = Topic.all
      render json: @topics, status: 200
    end

    # ログインユーザーのお気に入りトピック一覧を返す
    def likes
      @user = User.find_by(id: params[:user_id])
      @like_topics = @user.like_topics
      render json: @like_topics, status: 200
    end 

    # ログインユーザーの投稿したトピック一覧を返す
    def my_topics
      @user = User.find_by(id: params[:user_id])
      @topics = @user.topics
      render json: @topics, status: 200
    end

    # トピックの投稿アクション
    def create
      @topic = Topic.new
      @topic.user_id   = params[:user_id]
      @topic.shop_name = params[:shop_name]
      @topic.date      = params[:date]
      @topic.meals     = params[:meals]
      @topic.price     = params[:price]
      @topic.review    = params[:review]
      @topic.rating    = params[:rating]
      @topic.image     = params[:image]      

      @topics = Topic.all
      if @topic.save
        render json: 
          @topics,
          status: 200
      else
        render json: {
          status: 400
        }
      end
    end

    # トピック削除アクション
    def destroy
      @topic = Topic.find_by(id: params[:topic_id])
      if @topic.destroy
        render json: {
          status: 200
        }
      else
        render json: {
          status: 401
        }
      end
    end

  end
end