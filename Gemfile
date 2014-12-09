source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
gem 'rails-api'
gem 'pg'
gem 'thin'
gem 'warden'
gem 'state_machine'

gem 'linkedin'
gem 'carrierwave'

# Oauth provider 7 client
gem 'doorkeeper', '~> 0.7.0'
gem 'oauth2'

# Use SCSS for stylesheets
# gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
#gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jbuilder'

# To use ActiveModel has_secure_password
#gem 'bcrypt-ruby'
gem 'bcrypt-ruby', '3.1.2'
gem "handy-css-rails", "0.0.7"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "bootstrap-datepicker-rails"
gem "jquery-validation-rails"

# Use Capistrano for deployment
group :development do
  gem "parallel_tests"
  gem 'railroady'
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  #gem 'capistrano-console'
  #gem "capistrano-ext"
  #gem "capistrano-deploytags"
  gem "brakeman", :require => false
  gem "hirb"
end

group :development, :test do
  gem "factory_girl_rails"
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  #gem 'pry-debugger'
  gem "spork", "~> 1.0rc"
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rspec-rails' # Needed for rake stats to calculate test coverage
  gem "awesome_print"
  gem "quiet_assets"
end

gem 'rails_12factor', group: :production

group :it, :staging, :development, :test, :uat, :production do
  gem 'ruby-progressbar'
  gem "colorize"
end

group :test do
  gem "shoulda"
  gem 'cucumber-rails', :require => false
  gem 'cucumber-websteps'
  gem 'pickle'
  gem 'capybara'
  gem 'database_cleaner'
end
