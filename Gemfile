source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'tilt', '~> 1.4.1'
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'
gem 'endpoint_base', github: 'flowlink/endpoint_base'
gem 'httparty'
gem 'virtus'
gem 'activesupport'

group :development, :test do
  gem 'rake'
  gem 'pry'
  gem 'dotenv'
  gem 'simplecov', require: false
end

group :test do
  gem 'vcr'
  gem 'rspec'
  gem 'rack-test'
  gem 'webmock'
end

group :production do
  gem 'foreman'
  gem 'unicorn'
end
