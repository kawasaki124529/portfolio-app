class Topic < ApplicationRecord
  validates :user_id, presence: true
	validates :name, presence: true
	validates :date, presence: true
	validates :meals, presence: true
	validates :price, presence: true
	validates :review, presence: true
	validates :rating, presence: true
	validates :image, presence: true

  belongs_to :user

  mount_uploader :image, ImageUploader
end
