require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "refinery"

set :deploy_to,   "/var/www/#{application}"
set :user,        "webadmin"
set :port,        22101

set :scm,               :git
set :repository,        "ssh://git@10.10.10.1/refinery.git"
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
      run "touch #{File.join(current_path,'tmp','restart.txt')}"
    end
end

namespace :customs do
  task :symlink, :roles => :app do
    # Fetch production database
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/config/production.sqlite3"
    # Fetch old images directories
    %w(alx avatars binary_hero domiduino fildefeu lionel pg pressbook sack tetalab wikileaks).each do  |images|
      run "ln -nfs #{shared_path}/images/#{images} #{release_path}/public/images/#{images}"
    end
  end
end

# -- symlinks
after "deploy:symlink","customs:symlink"
