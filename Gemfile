source 'https://rubygems.org'

gem 'rails', '>= 3.2.7'

gem 'russian', '~> 0.6.0'


#usage stats
gem 'newrelic_rpm', platform: :ruby

#parser
gem 'instagram', require: false
gem 'tweetstream', require: false
gem 'oj', require: false
gem 'twitter', require: false
gem 'bluepill', platform: :ruby, require: false
gem 'daemons', require: false
gem 'libv8', platform: :ruby, require: false

#authorisation
gem 'omniauth'
gem 'omniauth-instagram'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'normalize-rails'

#various stuff
gem 'pacecar'
gem 'activeadmin'

#server
group :production do
  gem 'passenger'
end

group :development, :test do
  gem 'thin'
end

#db
gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '>= 3.2.3'
  gem 'coffee-rails', '>= 3.2.1'
  gem 'bootstrap-sass'

  gem 'therubyracer', platform: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
