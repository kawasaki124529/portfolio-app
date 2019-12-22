# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    user_id { '1' }
    sequence(:shop_name) { |n| "TEST_NAME#{n}" }
    date { Date.new(2019, 12, 20) }
    meals  { 'test_meals' }
    price  { '￥0-1000' }
    review  { 'test_review' }
    rating  { '3' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :user, factory: :user
  end
end
