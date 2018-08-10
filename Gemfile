source 'https://rubygems.org'

#ruby '2.4.2'

group :development, :test do
  gem 'byebug'
  gem 'cucumber', '2.0.0'
  gem 'capybara-screenshot'
  gem 'capybara', '2.4.4'
  gem 'selenium-webdriver'


  gem 'rspec-autotest', '1.0.0'

  gem 'rack-test', '0.6.3'
  gem 'rack_session_access', '0.1.1'

  gem 'launchy', '2.4.3'
  gem 'rerun', '0.10.0'

  gem 'simplecov', '0.10.0'
  gem 'webmock', '1.21.0'
  gem 'ZenTest', '4.11.0'
  
  gem 'sqlite3'

end

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "haml"
gem 'rails', '4.2.9'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rake'
gem 'rspec'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
end

gem 'delayed_job_active_record'

# added to support file attachment
# Q: Is the "beta1" necessary?
gem "paperclip", "~> 5.0.0.beta1"
gem 'carrierwave' # to upload files
gem 'simplecov-cobertura'

