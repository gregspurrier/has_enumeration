require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec'
require 'rspec/core/rake_task'


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "has_enumeration"
    gemspec.summary = "Support for symbol-based enumerations in ActiveRecord"
    gemspec.description = <<-EOF
Extends ActiveRecord with the has_enumeration method allowing a symbolic
enumeration to be stored in an ActiveRecord attribute.  The enumeration is
specified as a mapping between symbols and their underlying representation
in the database.  Predicates are provided for each symbol in the enumeration
and the symbols may be used in finder methods.  When using ActiveRecord 3,
the symbols may also be used when interacting with the underlying Arel attribute
for the enumeration.  has_enumeration has been tested with Ruby 1.8.7,
Ruby 1.9.2, JRuby 1.5.3, ActiveRecord 2.3.9, and ActiveRecord 3.0.0.
EOF
    gemspec.email = "greg@rujubu.com"
    gemspec.homepage = "http://github.com/gregspurrier/has_enumeration"
    gemspec.author = "Greg Spurrier"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

task :features => 'features:all'
namespace :features do
  task :all => [:common, :rails3]

  Cucumber::Rake::Task.new(:common) do |t|
    features = %w(explicitly_mapped_enumeration implicitly_mapped_enumeration
        nonstandard_attribute_enumeration)
    feature_files = features.map {|f| "features/#{f}.feature"}.join(' ')
    t.cucumber_opts = feature_files
  end

  Cucumber::Rake::Task.new(:rails3) do |t|
    features = %w(arel_attributes meta_where_queries)
    feature_files = features.map {|f| "features/#{f}.feature"}.join(' ')
    t.cucumber_opts = feature_files
  end
end

desc "Run all specs"
RSpec::Core::RakeTask.new('spec')
