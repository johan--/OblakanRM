require 'bundler/capistrano'
require 'rvm/capistrano'
require 'puma/capistrano'
require 'sidekiq/capistrano'

set :application, 'report'
set :rails_env, 'production'
set :domain, 'constXife@lunkserv.ru'
set :deploy_to, '/var/www/report.oblakan.ru'
set :use_sudo, false

set :scm, :git
set :repository,  'git@bitbucket.org:constXife/oblakanrm.git'
set :branch, 'master'
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :copy_exclude, ['.git']
set :keep_releases, 2
set :shared_children, shared_children + %w{public/uploads}

set :rvm_ruby_string, 'ruby-2.0.0'
set :rvm_type, :user
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

namespace :deploy do
  desc 'Symlink shared configs on each release.'
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/local_env.yml #{release_path}/config/local_env.yml"
  end
end

after 'deploy:update', 'deploy:cleanup'
after 'deploy:update', 'deploy:symlink_shared'