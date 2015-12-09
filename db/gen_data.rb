start_stamp = 1444409830
end_stamp =   1449684706
interval_period = end_stamp - start_stamp
first = 161

2.times{
  user = Random.rand(10) + 1
  random_stamp = Random.rand(interval_period) + start_stamp
  random_date = DateTime.strptime(random_stamp.to_s,'%s').strftime("%Y-%m-%d %H:%M:%S")
  p random_date
  click = Click.create(user_id: user, created_at: random_date, updated_at: random_date)
  click.created_at = random_date
  click.save
}

query = ""
60.times{ |x|
  id = first + x
  user = Random.rand(10) + 1
  random_stamp = Random.rand(interval_period) + start_stamp
  random_date = DateTime.strptime(random_stamp.to_s,'%s').strftime("%Y-%m-%d %H:%M:%S")
  query += "insert into clicks values (#{id}, #{user}, '#{random_date}', '#{random_date}');"
}
  p query
