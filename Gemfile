source 'http://rubygems.org'

RAILS_VERSION = '~> 3.1.8'

DATAMAPPER    = 'git://github.com/datamapper'

RSPEC         = 'git://github.com/rspec'
RSPEC_VERSION = '~> 2.6.0'

gem "activerecord", require: false
gem "arel", require: false
gem "activeresource", require: false
gem "rails", RAILS_VERSION

gem "tzinfo"
# gem "rack"

#git 'git://github.com/rails/rails.git' do

  gem 'activesupport',      RAILS_VERSION, :require => 'active_support'
  gem 'actionpack',         RAILS_VERSION, :require => 'action_pack'
  gem 'actionmailer',       RAILS_VERSION, :require => 'action_mailer'
  gem 'railties',           RAILS_VERSION, :require => 'rails'

#end

gem "json"
gem "xpath"
gem "nokogiri"

# 180389872 - 700GB
# 257699    - 1GB
# 77309945  - 300GB
# 154619890 - 600GB

#gem 'dm-rails',             DM_VERSION, :git => "#{DATAMAPPER}/dm-rails.git"
gem 'dm-rails'#,             DM_VERSION, :git => "git://github.com/datamapper/dm-rails.git"
#gem 'dm-sqlite-adapter',    DM_VERSION, :git => "#{DATAMAPPER}/dm-sqlite-adapter.git"
gem 'dm-pager'

# You can use any of the other available database adapters.
# This is only a small excerpt of the list of all available adapters
# Have a look at
#
#  http://wiki.github.com/datamapper/dm-core/adapters
#  http://wiki.github.com/datamapper/dm-core/community-plugins
#
# for a rather complete list of available datamapper adapters and plugins

gem 'dm-mysql-adapter'
gem 'dm-migrations'
gem 'dm-validations'#,       DM_VERSION, :git => "#{DATAMAPPER}/dm-validations"
gem 'dm-aggregates'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-aggregates"
gem 'dm-timestamps'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-timestamps"

group :development do
  gem "thin"
  gem "guard"
  gem "guard-livereload"
  gem "rerun"

  gem "capistrano", "2.15.5"
end

gem 'dm-core'#,              DM_VERSION, :git => "#{DATAMAPPER}/dm-core.git"
gem 'dm-do-adapter'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-do-adapter"
gem 'dm-active_model'#,      DM_VERSION, :git => "git://github.com/datamapper/dm-active_model"
gem "dm-is-tree"#,         git: "git://github.com/datamapper/dm-is-tree"

gem "dm-validations-i18n",  git: "https://github.com/komagata/dm-validations-i18n"

gem 'haml'
gem 'sass'

gem "exception_notification", :git => "git://github.com/rails/exception_notification"

gem "RedCloth"

gem "voidtools", git: "git://github.com/makevoid/voidtools"

#gem "ya2yaml", :git => "git://github.com/afunai/ya2yaml"

gem "mixpanel"


gem "skylight"
