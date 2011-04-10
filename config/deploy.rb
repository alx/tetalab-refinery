require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "refinery"

set :deploy_to,   "/var/www/#{application}"
set :user,        "webadmin"
set :port,        22101

set :scm,               :git
set :repository,        "ssh://git@10.10.10.1/jekyll.git"
set :scm_user,          "git"
set :branch,            "master"
set :deploy_via,        :remote_cache

role :web, "www.tetalab.org"
role :app, "www.tetalab.org"
role :db, "www.tetalab.org"

# ========================
#
# App tasks
#
# ========================

namespace :deploy do
  task :start do ; end
    task :stop do ; end
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end
end
