set :output, "./log/whenever.log"

every 60.minutes do
  rake "ts:index"
end
