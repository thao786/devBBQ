start_stamp = 1438387200
end_stamp = Time.now.to_i
interval_period = end_stamp - start_stamp

300.times { |x|
  user = Random.rand(User.count) + 1
  random_stamp = Random.rand(interval_period) + start_stamp
  random_date = DateTime.strptime(random_stamp.to_s, '%s').strftime("%Y-%m-%d %H:%M:%S")
  query = "insert into clicks (user_id, created_at, updated_at) values (#{user}, '#{random_date}', '#{random_date}');"
  ActiveRecord::Base.connection.execute(query)
}


