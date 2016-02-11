set :application, "cappiello"
# set :app_name, "cappiello"
set :app_name, "cappiello_staging"

# if ENV["ENV"] == "staging"
#   set :app_name, "cappiello_staging"
# end


# look at where are you deploying!




set :domain, "makevoid.com"

set :apps,        "/www"
set :deploy_to,   "#{apps}/#{app_name}"


set :use_sudo,    false
set :user,        "www-data"



#default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/makevoid-sites/cappiello.git"  # pub
# private
# set :repository, "git@github.com:makevoid/cappiello.git"  # Your clone URL
set :scm, "git"
# needed?
set :branch, "responsive_layout"

dot_pass = File.expand_path("~/.password")
File.open(dot_pass, "w"){|f| f.write("secret")} unless File.exist?(dot_pass)
password_var = File.read(dot_pass).strip
set :password,  password_var

# end
# set :scm_passphrase, password  # The deploy user's password

ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
# set :deploy_via, :copy


#
# set :scm_username, "makevoid"
#
# #File.read("/home/www-data/.password").strip
# set :password, File.read("/Users/makevoid/.password").strip
# set :scm_password, password
# # set :deploy_via, :copy
# # set :copy_exclude, [".git", "db", "nbproject", "public/images/cars"]
#

role :app, domain
role :web, domain
role :db,  domain, :primary => true


after :deploy, "deploy:create_symlinks"
after :deploy, "deploy:create_database_yml"
after :deploy, "deploy:create_mailer_init"
# after :deploy, "deploy:newrelic_secret"

after :deploy, "deploy:cleanup"
after :deploy, "chmod:entire"


namespace :deploy do

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Setup newrelic license key"
  task :newrelic_secret do
    newrelic_key = File.read(File.expand_path '~/Dropbox/.newrelic').strip
    run "ruby -e \"path = '#{current_path}/config'; db_yaml = File.read(path+'/newrelic.yml'); File.open(path+'/newrelic.yml', 'w'){ |f| f.write db_yaml.gsub(/LICENSE_KEY/, '#{newrelic_key}') }\""
  end


  desc "Create symlinks (managing server)"
  task :create_symlinks do
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/pdf pdf"
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/users_cv"
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/users_portfolio"
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/users_images"

    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/uploads uploads"
  end

  desc "Create database yml"
  task :create_database_yml do
    run "ruby -e \"path = '#{current_path}/config'; db_yaml = File.read(path+'/database.default.yml'); File.open(path+'/database.yml', 'w'){ |f| f.write db_yaml.gsub(/secret/, File.read(File.expand_path '~/.password').strip) }\""
  end


  desc "Create mailer initializer"
  task :create_mailer_init do
    run "ruby -e \"path = '#{current_path}/config/initializers'; db_yaml = File.read(path+'/mail.rb'); File.open(path+'/mail.rb', 'w'){ |f| f.write db_yaml.gsub(/secret/, File.read(File.expand_path '~/.password').strip.gsub(/33/, \'\')) }\""
  end


end

namespace :chmod do
  desc "chmod entire dir"
  task :entire do
    run "cd #{current_path}; chown www-data:www-data -R *"
    run "cd #{current_path}; git reset HEAD log/.gitignore"
    run "cd #{current_path}; git checkout log/.gitignore"
    run "cd #{current_path}; git add ."
    run "cd #{current_path}; git add -u"
    run "cd #{current_path}; git stash"
    run "cd #{current_path}; git checkout responsive_layout"
    # run "cd #{current_path}; git checkout responsive_layout"
    run "cd #{current_path}; git pull origin responsive_layout"
    run "cd #{current_path}; bundle"
    run "cd #{current_path}; touch tmp/restart.txt"
  end
end


set :apache_name, "apache2"
set :pub_domain, domain



def path
  File.expand_path File.dirname(__FILE__)
end


namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end

  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end

  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

# HOOKS
after "deploy:update_code" do
  bundler.bundle_new_release
  # ...
end



namespace :db do
  desc "Create database"
  task :create do
    run "mysql -u root --password=#{password_var} -e 'CREATE DATABASE IF NOT EXISTS #{application}_production;'"
  end

  desc "Seed database"
  task :seeds do
    run "cd #{current_path}; RAILS_ENV=production rake db:seeds"
  end

  desc "Send the local db to production server"
  task :toprod do
    # `rake db:seeds`
    env = ENV["ENV"] || "production"
    `mysqldump -u root #{application}_development > db/#{application}_development.sql`
    upload "db/#{application}_development.sql", "#{current_path}/db", via: :scp
    run "mysql -u root --password=#{password} #{application}_#{env} < #{current_path}/db/#{application}_development.sql"
  end

  desc "Get the remote copy of remote db"
  task :todev do
    remote_env = ENV["ENV"] || "production"
    run "mysqldump -u root --password=#{password} #{application}_#{remote_env} > #{current_path}/db/#{application}_#{remote_env}.sql"
    run "cd #{current_path}/db; tar cfj #{application}_#{remote_env}.tar.bz2 #{application}_#{remote_env}.sql; ls -alh #{application}_#{remote_env}.tar.bz2"

    download "#{current_path}/db/#{application}_#{remote_env}.tar.bz2", "db/#{application}_#{remote_env}.tar.bz2"
    local_path = `pwd`.strip
    `cd #{local_path}/db; tar xvfj #{application}_#{remote_env}.tar.bz2`
    `mysql -u root #{application}_development < #{local_path}/db/#{application}_#{remote_env}.sql`

    t = Time.now
    file = "#{application}_#{remote_env}_#{t.strftime("%Y_%m_%d")}.sql"
    `mv db/#{application}_#{remote_env}.sql db/#{file}`

    if ENV["BACKUP"] != "" || !ENV["BACKUP"].nil?
      `cp db/#{file} ~/db_backups/`
      puts "Backup saved on ~/db_backups/#{file}"
    end
  end
end
