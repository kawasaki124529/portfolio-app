class Api::LikeSerializer < ActiveModel::Serializer
  attributes :user_id,
             :topic_id
end
