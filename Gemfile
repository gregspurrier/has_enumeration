source :rubygems

version = ENV['AR_VERSION'] || '3.2.x'

if version.end_with? 'x'
  # fuzzy version support
  version = version.gsub /x$/, '0'
  gem 'activerecord', '~> ' +version, :require => 'active_record'
elsif version == '3'
  version = '3.0.0'
  gem 'activerecord', '~> 3.0', :require => 'active_record'
else
  gem 'activerecord', version, :require => 'active_record'
end

gem 'builder'

#if version >= '3.0.0'
#  group :meta_where do
#    gem 'squeel'
#  end
#end

group :development do
  gem 'jeweler'
end

group :test do
  gem 'rspec', '~> 2.3.0'
  gem 'cucumber'

  gem 'ruby-debug19'
  platforms :ruby do
    gem 'sqlite3-ruby', :require => 'sqlite3'
  end

  platforms :jruby do
    gem 'jdbc-sqlite3'
    gem 'activerecord-jdbcsqlite3-adapter', '~> 0.9.7'
  end
end
