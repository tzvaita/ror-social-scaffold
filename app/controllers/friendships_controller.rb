class FriendshipsController < ApplicationController
  before_action :find_friendship, only: [:destroy, :edit]

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build({friend_id: params[:friend_id], confirmed: false})
    if @friendship.save
      flash[:success] = 'Friendship request sent successfully'
      redirect_to users_path
    else
      flash[:danger] = 'Friendship request send failed'
      redirect_to users_path
    end
  end

  def edit
    if @friendship_id
      @friendship_id.update_attribute(:confirmed, true)
      flash[:success] = 'Friendship request accepted'
      redirect_to users_path
    else
      flash[:danger] = 'Friendship request not accepted'
      redirect_to users_path
    end
  end

  def destroy
    if @friendship_id
      @friendship_id.destroy
      flash[:success] = 'Friendship request cancelled'
      redirect_to users_path
    else
      flash[:danger] = 'Friendship request NOT cancelled'
    end
  end

  private

  def find_friendship
    @friendship_id = Friendship.find(params[:id])
  end
end