source :rubygems

version = ENV['AR_VERSION'] || '3.0.x'

if version.end_with? 'x'
  # fuzzy version support
  version = version.gsub /x$/, '0'
  gem 'activerecord', '~> ' +version, :require => 'active_record'
else
  gem 'activerecord', version, :require => 'active_record'
end

gem 'builder', '~> 2.1.2'

if version >= '3.0.0' && version < '3.1'
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
