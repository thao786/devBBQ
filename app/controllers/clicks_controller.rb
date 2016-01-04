class ClicksController < ApplicationController
  layout "clicks"
  before_filter :authenticate_user!

  def initialize
    super # this calls ActionController::Base initialize
    @min = getMinMonth
  end

  def index
    @click = Click.new
    @month = Date.today.strftime("%m")
    @stat = getClickStat(@month)
    @max = @month
  end

  def email(from_addr)
    client = SendGrid::Client.new(api_user: ENV["SENDGRID_USERNAME"], api_key: ENV["SENDGRID_KEY"])

    mail = SendGrid::Mail.new do |m|
      m.to = 'careers@devbbq.com'
      m.from = from_addr
      m.subject = 'Email for Dev Assignment'
      m.text = 'Another person signed up to donate $1000 to Wikipedia.'
    end

    res = client.send(mail)
  end

  def getClickStat(month)
    result = Click.where('month(created_at) = ' + month).group("DATE_FORMAT(created_at, '%d')").count

    hash = {}
    result.each{|k,v|
      hash[k.to_i] = v
    } #mysql result doesn't contain dates with 0 click

    statistic = [] #force stat for each day
    (1..31).each{ |x|
      hash[x] ? statistic << hash[x] : statistic << 0
    }
    statistic
  end

  def getMinMonth
    Click.minimum('created_at').month
  end

  def show
    render json: getClickStat(params["id"])
  end

  def create
    params = {user_id: current_user.id}
    @click = Click.create(params)
    email current_user.email
    render json: current_user.id
  end

end
