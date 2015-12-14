class ClicksController < ApplicationController
  layout "clicks"
  before_filter :authenticate_user!

  def initialize
    super # this calls ActionController::Base initialize
    @min = getMinMonth 2015
  end

  def index
    @click = Click.new
    @month = Date.today.strftime("%m")
    @stat = stat(@month)
    @max = @month
  end

  def email(from_addr)
    client = SendGrid::Client.new(api_user: ENV["SENDGRID_USERNAME"], api_key: ENV["SENDGRID_KEY"])

    mail = SendGrid::Mail.new do |m|
      m.to = 'careers@devbbq.com'
      m.from = from_addr
      m.subject = 'Testing Email for Dev Assignment'
      m.text = 'Another person signed up to donate $1000 to Wikipedia.'
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

    result = ActiveRecord::Base.connection.execute(query).to_a
    result.map!{ |x|
      [x[0].to_i, x[1]]
    } # convert all keys to integer

    hash = {}
    result.each{|x|
      hash[x[0]] = x[1]
    } #mysql result doesn't contain dates with 0 click

    statistic = [] #force stat for each day
    (1..31).each{ |x|
      hash[x] ? statistic << hash[x] : statistic << 0
    }
    statistic
  end

  def getMinMonth(year)
    query =
        "SELECT
            min(month(created_at))
        FROM
            clicks
        WHERE
            year(created_at) = #{year};"

    result = ActiveRecord::Base.connection.execute(query).to_a
    return result[0][0]
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
