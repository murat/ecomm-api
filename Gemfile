# frozen_string_literal: true
source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rubocop-rails'
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'pry-rails'

  # Test
  gem 'rubocop-rspec', require: false
  gem 'rspec-rails', '~> 3.8'
  gem 'faker'
  gem 'factory_bot_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1', require: false

  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Authentication
gem 'devise'
gem 'doorkeeper', '~> 5.3.2'
gem 'doorkeeper-jwt'

# Utilities
gem 'ancestry'
gem 'acts_as_list'
gem 'kaminari'

gem 'fast_jsonapi'
