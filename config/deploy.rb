set :application, 'OctoCrowd'


# git
set :scm, :git
set :repo_url, 'git@github.com:nd0ut/octo-crowd.git'
set :branch, 'testing'

set :deploy_to, '/home/rails/octo-crowd'
set :deploy_via, :remote_cache


# capistrano config
set :format, :pretty
set :log_level, :debug
set :pty, false

set :linked_dirs, %w{db/sphinx log tmp/pids tmp/cache tmp/sockets public/system}

set :default_env, { path: "/home/rails/.rvm/bin:$PATH" }
set :keep_releases, 1


# rvm config
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0@rails4'
set :rvm_custom_path, '/home/rails/.rvm'


# unicorn config
set :unicorn_bundle, "#{fetch :rvm_custom_path}/bin/bundle"


# sidekiq config
set :sidekiq_pid, "tmp/pids/sidekiq.pid"
SSHKit.config.command_map[:sidekiq] = "#{fetch :rvm_custom_path}/bin/bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "#{fetch :rvm_custom_path}/bin/bundle exec sidekiqctl"


set :whenever_command, "bundle exec whenever"
set :whenever_identifier, ->{ "#{fetch :application}_#{fetch :stage}" }

# deploy hooks
after 'deploy', 'unicorn:restart'
after 'deploy', 'sidekiq:restart'
after 'deploy', 'thinking_sphinx:restart'
after 'deploy', 'whenever:update_crontab'

# whenever hooks
before 'whenever:update_crontab', 'rvm:hook'
before 'whenever:clear_crontab', 'rvm:hook'

# sphinx hooks
before "thinking_sphinx:configure", 'rvm:hook'
before "thinking_sphinx:index", 'rvm:hook'
before "thinking_sphinx:restart", 'rvm:hook'
before "thinking_sphinx:start", 'rvm:hook'
before "thinking_sphinx:stop", 'rvm:hook'

# sidekiq hooks
before 'sidekiq:quiet', 'rvm:hook'
before 'sidekiq:restart', 'rvm:hook'
before 'sidekiq:start', 'rvm:hook'
before 'sidekiq:stop', 'rvm:hook'

# unicorn hooks
before "unicorn:add_worker", 'rvm:hook'
before "unicorn:duplicate", 'rvm:hook'
before "unicorn:reload", 'rvm:hook'
before "unicorn:remove_worker", 'rvm:hook'
before "unicorn:restart", 'rvm:hook'
before "unicorn:show_vars", 'rvm:hook'
before "unicorn:shutdown", 'rvm:hook'
before "unicorn:start", 'rvm:hook'
before "unicorn:stop", 'rvm:hook'


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end