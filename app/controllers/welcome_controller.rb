class WelcomeController < ApplicationController
    def say_hello
      @user = User.find(params[:id])
    end
end
