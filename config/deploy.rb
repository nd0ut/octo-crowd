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
set :pty, true

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}

set :default_env, { path: "/home/rails/.rvm/bin:$PATH" }
set :keep_releases, 1


# rvm config
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0@rails4'
set :rvm_custom_path, '/home/rails/.rvm'


# unicorn config
set :unicorn_bundle, "#{fetch :rvm_custom_path}/bin/bundle"


# hooks
before 'unicorn:start', 'rvm:hook'
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