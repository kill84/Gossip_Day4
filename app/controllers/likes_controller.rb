class LikesController < ApplicationController
before_action :authenticate_user

  def new
    @like = Like.new
  end

  def create
      id = session[:user_id]
      @like = Like.create('gossip_id'=> params[:gossip_id], 'user_id' => current_user.id)

      if @like.save
      redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

    private

  def authenticate_user
    id = session[:user_id]
    unless current_user
      flash[:danger] = "Please log in"
      redirect_to new_session_path
    end
  end

end
