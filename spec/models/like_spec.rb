require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create!(name: 'Foo', email: 'foobar@example.org', password: 'foobar', password_confirmation: 'foobar')
    @post = Post.create!(content: 'Content', user_id: @user.id)
    @comment = Comment.create!(content: 'Text Comment', user_id: @user.id, post_id: @post.id)
    @like1 = @post.likes.build(post_id: @post_id, user_id: @user.id)
    @like2 = @post.likes.build(post_id: @post_id, user_id: @user.id)
  end

  context 'with valid details' do
    it 'should create a like in a post' do
      expect(@like1).to be_valid
    end

    it 'should create a like in a comment' do
      expect(@like2).to be_valid
    end
  end
end
