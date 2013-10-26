set :application, 'OctoCrowd'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :scm, :git

set :repo_url, 'git@github.com:nd0ut/octo-crowd.git'
set :branch, 'master'

set :deploy_to, '/home/rails/octo-crowd'
set :deploy_via, :remote_cache


set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}

set :default_env, { path: "/home/rails/.rvm/bin:$PATH" }
set :keep_releases, 1

set :rvm_type, :user
set :rvm_ruby_version, '2.0.0@rails4'
set :rvm_custom_path, '/home/rails/.rvm'
set :bundle_cmd, 'OctoCrowd_bundle'

SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"

after 'deploy', 'unicorn:restart'

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