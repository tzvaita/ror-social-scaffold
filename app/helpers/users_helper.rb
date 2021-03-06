module UsersHelper
  def gravatar_for(current_user)
    gravatar_id = Digest::MD5.hexdigest(current_user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: current_user.name, class: 'gravatar')
  end

  def me?(user)
    user == current_user
  end

  # Users who have yet to confirm friendship
  def users_pending_to_accept_my_request(user)
    friendship1 = @friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
    friendship1.include?(user)
  end

  def pending_for_me_to_accept(user)
    friendship2 = @inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
    friendship2.include?(user)
  end

  def friends_already(user)
    friends_list = @friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_list += @inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_list.compact
    friends_list.include?(user)
  end

  def find_friendship_id(user)
    Friendship.find_by(user_id: current_user.id, friend_id: user.id) ||
      Friendship.find_by(user_id: user.id, friend_id: current_user.id)
  end

  def list_pending_friends(_user)
    friendship2 = @inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
    friendship2
  end
end
