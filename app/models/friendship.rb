class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_uniqueness_of :user_id, :scope => :friend_id
  validates :friend_id, exclusion: { in: ->(u) { [u.user_id] } }
end
