source 'https://rubygems.org'

gem 'rails', '>= 3.2.7'


#parser
gem 'instagram'
gem 'tweetstream'
gem 'daemons'

#authorisation
gem 'omniauth'
gem 'omniauth-instagram'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

#various stuff
gem 'pacecar'
gem 'activeadmin'

#server
gem 'thin'
group :production do
  gem 'passenger'
  gem 'mysql2'
end

group :development, :test do
  gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '>= 3.2.3'
  gem 'coffee-rails', '>= 3.2.1'
  gem 'bootstrap-sass'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platform: :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'rspec-rails'
  gem 'webrat'
  gem 'capybara'
  gem 'spork', '>=1.0.0rc3'
  gem 'factory_girl_rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
