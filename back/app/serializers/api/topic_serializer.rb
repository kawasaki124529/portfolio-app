# frozen_string_literal: true

class Api::TopicSerializer < ActiveModel::Serializer
  attributes  :id,
              :created_at,
              :date,
              :id,
              :image,
              :meals,
              :price,
              :rating,
              :review,
              :shop_name,
              :updated_at,
              :user_id

  has_one :user
  has_many :likes, serializer: Api::LikeSerializer
  has_many :comments, serializer: Api::CommentSerializer
end
