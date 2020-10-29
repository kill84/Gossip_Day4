module LikesHelper

  def get_like(user, gossip)
      Like.find_by(user_id: user.id, gossip_id: gossip.id)
  end

end
