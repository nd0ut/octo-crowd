job_type :rake,    "cd :path && :environment_variable=:environment bundle exec rake :task :output"

set :output, "./log/whenever.log"

every 60.minutes do
  rake "ts:index"
end
