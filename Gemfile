source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'redis', '~> 4.0'

# Auth
gem 'bcrypt', '~> 3.1.7'
gem 'doorkeeper'

# API
gem 'active_model_serializers'
gem 'api-pagination'
gem 'jsonapi-serializer'
gem 'pagy'
gem 'rack-cors'
gem 'validates_email_format_of'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
