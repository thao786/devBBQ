class ClicksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @click = Click.new
    @month = Date.today.strftime("%m")
    @stat = stat(@month)
    @min = 10
    @max = @month
  end

  def email(from_addr)
    client = SendGrid::Client.new(api_user: 'thao786', api_key: 'fall2010')

    mail = SendGrid::Mail.new do |m|
      m.to = 'roseskindergarten@gmail.com'
      m.from = from_addr
      m.subject = 'Testing Email for Dev Assignment'
      m.text = 'I am quick at typing, about 25 words per minute.'
    end

    res = client.send(mail)
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
    email current_user.email
    render json: current_user.id
  end

end
