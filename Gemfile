source 'http://rubygems.org'

gem 'activerecord', '>= 2.3.8', :require => 'active_record'

group :meta_where do
  gem 'meta_where'
end

group :test do
  gem 'rspec', '~> 2.1.0'
  gem 'cucumber', '~> 0.9.3'

  platforms :ruby do
    gem 'sqlite3-ruby', :require => 'sqlite3'
  end

  platforms :jruby do
    gem 'jdbc-sqlite3'
    gem 'activerecord-jdbcsqlite3-adapter', '~> 0.9.7'
  end
end
