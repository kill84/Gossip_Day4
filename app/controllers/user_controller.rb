class UserController < ApplicationController

  def show
    id = params[:id]
    @userfind = User.find(params[:id])
  end

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create('first_name' => params[:first_name], 'last_name' => params[:last_name], 'description' => params[:description], 'email' => params[:email], 'password' => params[:password], 'age' => params[:age], 'city_id' => params[:city_id])

    if @user.save
    session[:user_id] = @user.id
    redirect_to welcome_path(@user.id)
    flash[:notice]= "Post successfully created"
    else
      flash[:alert] = "Post aborted"
      render 'new'
    end
  end

end
