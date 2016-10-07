source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use Bcraypt for has_secure_password mthod
gem 'bcrypt', '~> 3.1.7'
# Pagination gems
gem 'will_paginate', '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-rails', '~> 4.6', '>= 4.6.1.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use devise for user management
gem 'devise'
gem 'simple_token_authentication', '~> 1.0'
# Use Paperclip for image upload function
gem 'paperclip', '~> 4.1'
# Use AWS gems with Paperclip so images can be stored even in Heroku
gem 'aws-sdk', '< 2.0'
# Use Stripe for credit card payment
gem 'stripe'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

# ------------- #
# - for Debug - #
# ------------- #

group :development, :test do
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-rails'
  # 優化 console 顯示
  gem 'awesome_print', require: false
  gem 'hirb', require: false
  gem 'hirb-unicode', require: false
  # displays speed badge for every html page
  gem 'rack-mini-profiler', '0.10.1'
  gem 'flamegraph'
  gem 'stackprof'
  # rails 4 tools
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
