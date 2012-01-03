source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'devise'

gem "date_validator", "~> 0.6.2"

gem "rocket_tag"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'rake', '>= 0.9.2'
  gem 'therubyracer'
	# Use unicorn as the web server
	gem 'unicorn'
end