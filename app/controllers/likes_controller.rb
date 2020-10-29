class LikesController < ApplicationController
before_action :authenticate_user

  def new
    @like = Like.new
  end

  def create
      id = session[:user_id]
      current_user = User.find(id)
      @like = Like.create('gossip_id'=> params[:gossip_id], 'user_id' => current_user.id)

      if @like.save
      redirect_to gossip_path(@like.gossip.id)
      else
        redirect_to gossip_path(@like.gossip.id)
      end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to gossip_path(params[:gossip_id])
  end

    private

  def authenticate_user
    id = session[:user_id]
    current_user = User.find(id)
    unless current_user
      flash[:danger] = "Please log in"
      redirect_to new_session_path
    end
  end

end
