# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe User do
    it '有効なファクトリを使用していること' do
      expect(user).to be_valid
    end
  end

  it '重複したメールアドレスは無効になること' do
    user1 = create(:user, email: 'taro@example.com')
    expect(build(:user, email: user1.email)).to_not be_valid
  end

  describe 'メールアドレスの有効性についてのテスト' do
    it '無効なメールアドレスの場合使用できないこと' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it '有効なメールアドレスの場合使用できること' do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe 'パスワードについてのテスト' do
    it 'パスワードが一致しない場合無効になること' do
      user = build(:user, password: 'password', password_confirmation: 'different')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'パスワードが一致した場合有効になること' do
      user = FactoryBot.build(:user, password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end
  end
end
