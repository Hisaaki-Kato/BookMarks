# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'

gem 'bcrypt',                  '3.1.12'
gem 'bootstrap',               '~> 4.3.1'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'carrierwave',             '1.2.2'
gem 'httparty'
gem 'jquery-rails'
gem 'json'
gem 'websocket-extensions', '>= 0.1.5'
gem 'will_paginate', '3.1.7'

gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'guard', '2.16.2'
  gem 'guard-minitest', '2.4.4'
  gem 'launchy'
  gem 'minitest', '5.10.3'
  gem 'minitest-reporters', '1.1.14'
  gem 'rails-controller-testing', '1.0.2'
  gem 'webdrivers'
end

group :production do
  gem 'mysql2'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
