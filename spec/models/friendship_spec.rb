require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user1 = User.create!(name: 'Tenny', email: 'tenny@gmail.com', password: '123456', password_confirmation: '123456')
    @user2 = User.create!(name: 'Ten', email: 'ten@gmail.com', password: '123457', password_confirmation: '123457')
    @friend = Friendship.create!(user_id: @user1.id, friend_id: @user2.id, confirmed: false)
  end

  context 'with valid details' do
    it 'should create friendship' do
      expect(@friend).to be_valid
    end

    it 'should have a friend' do
      expect(@user1.friendships).not_to be_empty
    end

    it 'should have an inverse friend' do
      expect(@user2.inverse_friendships).not_to be_empty
    end
  end
end
