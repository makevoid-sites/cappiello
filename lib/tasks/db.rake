
namespace :db do

  desc "seed"
  task :seeds => :environment do
    DataMapper.auto_migrate!
    require File.expand_path('../../../db/seeds', __FILE__)
  end

  desc "dump to yaml"
  task :dump => :environment do
    require "#{Rails.root}/lib/dm_utils"
    include DmUtils
    dump_to_yaml(Page, "pages")
  end
  
  desc "load from yaml"
  task :load => :environment do
    repository.adapter.execute "TRUNCATE TABLE pages"
    pages = YAML::load File.read("#{Rails.root}/db/pages.yml")
    pages.map do |page|
      pp = Page.create(page)
    end
  end

end
