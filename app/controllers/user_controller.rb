class UserController < ApplicationController
  def show
    id = params[:id]
    @userfind = User.find(params[:id])
  end
  def index
    @user = User.all
  end
end
