require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.create!(name: 'Foo',  email: 'goobar@example.org', password: 'foobar', password_confirmation: 'foobar')
    @post = Post.create!(content: 'Content', user_id: @user.id)
    @comment = Comment.create!(content: 'Text Comment', user_id: @user.id, post_id: @post.id)
  end

  context 'with valid details' do
    it 'should create a comment' do
      expect(@comment).to be_valid
    end

    it 'should have text' do
      expect(@comment.content).to be_present
    end
  end

  context 'with invalid details' do
    it 'should not be valid because it does not have a text' do
      @comment.content = '    '
      expect(@comment).to_not be_valid
    end
  end
end
