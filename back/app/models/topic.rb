class Topic < ApplicationRecord
  validates :user_id, presence: true
	validates :shop_name, presence: true
	validates :date, presence: true
	validates :meals, presence: true
	validates :price, presence: true
	validates :review, presence: true
	validates :rating, presence: true
	validates :image, presence: true

	belongs_to :user
	has_many :likes
	has_many :comments

  mount_uploader :image, ImageUploader
end
