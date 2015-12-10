class ClicksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @click = Click.new
    @month = Date.today.strftime("%m")
    @stat = stat(@month)
    @min = 10
    @max = 12
  end

  def stat(month)
    query =
        "SELECT
            DATE_FORMAT(created_at, '%d'),
            count(*)
        FROM
            clicks
        WHERE
            month(created_at) = #{month}
        GROUP BY
            date(created_at);"

    result = ActiveRecord::Base.connection.execute(query)
    result.to_a.map { |x|
      x[1]
    }
  end

  def show
    render json: stat(params["id"])
  end

  def create
    params = {user_id: current_user.id}
    @click = Click.create(params)
    render json: current_user.id
  end

end
