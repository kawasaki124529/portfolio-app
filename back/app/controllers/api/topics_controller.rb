module Api
  class TopicsController < ApplicationController
    def new
      @topic = Topic.new
    end

    def index
      @topics = Topic.all
      render json: @topics, status: 200
    end
    # def show
    #   @dog = Dog.find(params[:id])
    #   render json: {
    #     dog: {
    #       name: @dog.name,
    #       pic:  @dog.pic.url
    #     },
    #     status: 200
    #   }
    # end

    def create
      raise ArgumentError, 'invalid params' if params[:image].blank? || params[:name].blank?
      @topic = Topic.new
      @topic.user_id   = params[:user_id]
      @topic.shop_name = params[:shop_name]
      @topic.date      = params[:date]
      @topic.meals     = params[:meals]
      @topic.price     = params[:price]
      @topic.review    = params[:review]
      @topic.rating    = params[:rating]
      @topic.image     = params[:image]      
      if @topic.save
        render json: {
          topic: {
            topic: @topic,
          },
          status: 200
        }
      else
        render json: {
          status: 400
        }
      end
    end
  end
end