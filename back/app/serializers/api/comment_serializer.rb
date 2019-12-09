class Api::CommentSerializer < ActiveModel::Serializer
  attributes :content,
             :user
             :created_at

  has_one :user
end
