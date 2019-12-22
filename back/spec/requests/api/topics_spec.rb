require 'rails_helper'

RSpec.describe "Topics", type: :request do

  before(:each) do
    @topic = create(:topic)
  end

  describe 'GET /api/topics' do
    it '全てのポストを取得する GET#index' do
      get '/api/topics/'
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/topics" do
    it "新しいトピックを投稿する POST#create" do
      post '/api/topics', params: { params: attributes_for(:topic) }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      # リクエスト成功を表す200が返ってきたか確認する。
    end
  end
end