source 'http://rubygems.org'

if  ENV['AR_VERSION'] == '2.3'
  gem 'activerecord', '2.3.8'
else
  gem 'activerecord', '>= 3.0.0.rc'
end

gem 'rspec', '>= 2.0.0.beta.19'
gem 'cucumber', '>= 0.8.5'

platforms :ruby do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

platforms :jruby do
  gem 'jdbc-sqlite3'
  gem 'activerecord-jdbcsqlite3-adapter', '>= 0.9.7'
end
