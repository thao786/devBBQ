class ClicksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @click = Click.new
    @stat = stat
  end

  def stat
    query = "select DATE_FORMAT(created_at, '%d'), count(*) from clicks where month(created_at) = 11 group by date(created_at);"
    result = ActiveRecord::Base.connection.execute(query)
    result.to_a.map { |x|
      x[1]
    }
  end

  def show
    render json: stat
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
