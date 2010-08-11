source 'http://rubygems.org'

gem 'activerecord', '>= 3.0.0.rc'
gem 'rspec', '>= 2.0.0.beta.19'
gem 'cucumber', '>= 0.8.5'

if defined?(JRUBY_VERSION)
  gem 'jdbc-sqlite3'
  gem 'activerecord-jdbcsqlite3-adapter', '>= 0.9.7'
else
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
