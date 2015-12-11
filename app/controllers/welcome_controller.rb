class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to clicks_path
    else
      render layout: false
    end
  end
end
