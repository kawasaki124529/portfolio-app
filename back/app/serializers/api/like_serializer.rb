# frozen_string_literal: true

class Api::LikeSerializer < ActiveModel::Serializer
  attributes :user_id,
             :topic_id
end
