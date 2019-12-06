class Api::CommentSerializer < ActiveModel::Serializer
  attributes :content,
             :user

  has_one :user
end
