class ClicksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @click = Click.new
    #statistic query
  end

  def new
    render plain: 4
  end

  def create
    params = {user_id: current_user.id}
    @click = Click.create(params)
    render plain: 4
  end

end
