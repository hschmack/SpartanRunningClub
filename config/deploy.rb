# config valid only for Capistrano 3.1
lock '3.1.0'

require 'capistrano/bundler'
require 'capistrano/rvm'
set :rvm_ruby_string, '2.1.1'
set :rvm_type, :user

set :application, 'SpartanRunningClub'
set :repo_url, 'git@github.com:ajm188/SpartanRunningClub.git'

set :deploy_to, '/home/andrew/SpartanRunningClub'
set :deploy_via, :copy

set :scm, :git
set :branch, :master

set :user, 'andrew'

set :rails_env, 'production'

set :keep_releases, 3

set :pty, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

after "deploy", "bootstrap:admin"