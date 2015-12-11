class WelcomeController < ApplicationController
  def index
    @users = User.all

    if user_signed_in?
      redirect_to clicks_path
    end
  end
end
