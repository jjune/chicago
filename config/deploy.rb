set :application, "chicago"
set :repository,  "git@github.com:jjune/chicago.git"
set :scm, "git"
set :deploy_to, "/var/www/vhosts/supersecretlabs.com/subdomains/chicago"
server "chicago.supersecretlabs.com", :app, :web, :db, :primary => true

set :user, "deploy"
set :scm_username, "deploy@supersecretlabs.com"
set :runner, "deploy"
default_run_options[:pty] = true
set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

desc "Make symlink for database yaml" 
 task :symlink do
   run "ln -nfs #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml" 
 end
 
desc "Update .htaccess file to remove cgi and fcgi invocation, create symbloic link for database.yml"
   task :update_config, :roles => [:app] do
     run "echo \'ErrorDocument 500 \"Application error Rails application failed to start properly\"\' > /var/www/vhosts/supersecretlabs.com/subdomains/chicago/current/public/.htaccess"
     run "ln -nfs #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml" 
end
 
 
require 'erb'
before "deploy:setup", :db
after "deploy:update_code", "db:symlink"
before "deploy:restart", :update_config

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: postgresql
      database: chicago_development
      username: postgres
      password: 
      host: localhost
      port: 5432

    development:
      database: #{application}_development
      <<: *base

    test:
      database: #{application}_test
      <<: *base

    production:
      database: #{application}_development
      <<: *base
    EOF

    run "mkdir -p #{deploy_to}/shared/config" 
    put db_config.result, "#{deploy_to}/shared/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml" 
  end
end

namespace :deploy do 
  namespace :mongrel do
    [ :stop, :start, :restart ].each do |t|
      desc "#{t.to_s.capitalize} the mongrel appserver"
      task t, :roles => :app do
        #invoke_command checks the use_sudo variable to determine how to run the mongrel_rails command
        invoke_command "mongrel_rails cluster::#{t.to_s} -C #{mongrel_conf}", :via => run_method 
      end
    end
  end

  desc "Custom restart task for mongrel cluster"
  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.mongrel.restart
  end

  desc "Custom start task for mongrel cluster"
  task :start, :roles => :app do
    deploy.mongrel.start
  end

  desc "Custom stop task for mongrel cluster"
  task :stop, :roles => :app do
    deploy.mongrel.stop
  end
end