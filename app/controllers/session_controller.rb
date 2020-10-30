class SessionController < ApplicationController

  def new

  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    @user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if @user && @user.authenticate(params[:password])

      log_in(@user)
      if params[:remember_me]
          # on va cuisiner le cookie pour l'utilisateur
      remember(@user)

      redirect_to welcome_path(@user.id)
      flash[:alert]= "Welcome to your session"
      else
        remember_temp(@user)
        redirect_to welcome_path(@user.id)
      end
    else
      flash[:alert] = "Invalid password/email"
      render 'new'
    end
  end

  def destroy
    log_out(current_user)
    redirect_to new_session_path
  end

end
