class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    result = []
    friendships.where(friendship_status: true).each do |x|
      result << x.friend
    end
    result
  end

  def inverse_friends
    result = [self]
    inverse_friendships.where(confirmed: true).each do |x|
      result << x.user
    end
    result
  end

  def friends_and_own_posts
    Post.where(user: (friends + inverse_friends))
  end

end
