require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create!(name: 'Foo', email: 'foobar@example.org', password: 'foobar', password_confirmation: 'foobar')
    @post = @user.posts.build(content: 'Content')
  end

  context 'with valid details' do
    it 'should create a post' do
      expect(@post).to be_valid
    end

    it 'should have a content' do
      expect(@post.content).to be_present
    end
  end

  context 'with invalid details' do
    it 'should not be valid' do
      @post.content = '    '
      expect(@post).to_not be_valid
    end
  end
end
