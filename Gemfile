source 'http://rubygems.org'

RAILS_VERSION = '~> 3.1.8'

DATAMAPPER    = 'git://github.com/datamapper'
DM_VERSION    = '~> 1.3.0.beta'
DM_VERSION2    = '~> 1.1.1'

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

# You can use any of the other available database adapters.
# This is only a small excerpt of the list of all available adapters
# Have a look at
#
#  http://wiki.github.com/datamapper/dm-core/adapters
#  http://wiki.github.com/datamapper/dm-core/community-plugins
#
# for a rather complete list of available datamapper adapters and plugins

gem 'dm-mysql-adapter'#,     DM_VERSION, :git => "#{DATAMAPPER}/dm-mysql-adapter.git"
# gem 'dm-postgres-adapter',  DM_VERSION, :git => "#{DATAMAPPER}/dm-postgres-adapter.git"
# gem 'dm-oracle-adapter',    DM_VERSION, :git => "#{DATAMAPPER}/dm-oracle-adapter.git"
# gem 'dm-sqlserver-adapter', DM_VERSION, :git => "#{DATAMAPPER}/dm-sqlserver-adapter.git"

gem 'dm-migrations'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-migrations"
# gem 'dm-types',             DM_VERSION, :git => "#{DATAMAPPER}/dm-types"
gem 'dm-validations'#,       DM_VERSION, :git => "#{DATAMAPPER}/dm-validations"
#gem 'dm-constraints',       DM_VERSION, :git => "#{DATAMAPPER}/dm-constraints"
# gem 'dm-transactions',      DM_VERSION, :git => "#{DATAMAPPER}/dm-transactions.git"
gem 'dm-aggregates'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-aggregates"
gem 'dm-timestamps'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-timestamps"
# gem 'dm-observer',          DM_VERSION, :git => "#{DATAMAPPER}/dm-observer"

group :development, :test do
  # gem 'rspec-rails'
  # gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  # gem 'launchy'
  # gem 'steak'
  # gem 'database_cleaner'
end

group :development do
  gem "thin"
  gem "guard"
  gem "guard-livereload"
  gem "rerun"
end

# ------------------------------------------------------------------------------

# These gems are only listed here in the Gemfile because we want to pin them
# to the github repositories for as long as no stable version has been released.
# The dm-core gem is a hard dependency for dm-rails so it would get pulled in by
# simply adding dm-rails. The dm-do-adapter gem is a hard dependency for any of
# the available dm-xxx-adapters. Once we have stable gems available, pinning these
# gems to github will be optional.

gem 'dm-core'#,              DM_VERSION, :git => "#{DATAMAPPER}/dm-core.git"
gem 'dm-do-adapter'#,        DM_VERSION, :git => "#{DATAMAPPER}/dm-do-adapter"
#gem 'dm-active_model',      DM_VERSION, :git => "#{DATAMAPPER}/dm-active_model"
gem 'dm-active_model'#,      DM_VERSION, :git => "git://github.com/datamapper/dm-active_model"


gem "dm-is-tree"#,         git: "git://github.com/datamapper/dm-is-tree"
# gem "dm-is-protectable"#,  git: "git://github.com/makevoid/dm-is-protectable"
#
# gem 'warden', '~> 0.10.4', :git => "git://github.com/hassox/warden.git"
# gem 'devise', '~> 1.1.rc1', :git => "git://github.com/plataformatec/devise.git"

gem "dm-validations-i18n",  git: "git://github.com/makevoid/dm-validations-i18n.git"

#gem 'haml', '~> 3.1.0', :git => "git://github.com/nex3/haml.git"
gem 'haml'
gem 'sass'

gem "exception_notification", :git => "git://github.com/rails/exception_notification"

# gem "bluecloth"
gem "RedCloth"

gem "voidtools", git: "git://github.com/makevoid/voidtools"

#gem "ya2yaml", :git => "git://github.com/afunai/ya2yaml"

gem "mixpanel"

gem 'newrelic_rpm'

gem "thin"


