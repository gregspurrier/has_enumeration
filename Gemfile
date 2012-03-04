source 'http://rubygems.org'

ENV['AR_VERSION'] ||= '3.0.3'

gem 'activerecord', ENV['AR_VERSION'], :require => 'active_record'

if ENV['AR_VERSION'] >= '3.0.0'
  group :meta_where do
    gem 'meta_where'
  end
end

group :development do
  gem 'jeweler'
end

group :test do
  gem 'rspec', '~> 2.3.0'
  gem 'cucumber'

  platforms :ruby do
    gem 'sqlite3-ruby', :require => 'sqlite3'
  end

  platforms :jruby do
    gem 'jdbc-sqlite3'
    gem 'activerecord-jdbcsqlite3-adapter', '~> 0.9.7'
  end
end
