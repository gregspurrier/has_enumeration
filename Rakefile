require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "has_enumeration"
    gemspec.summary = "Support for symbol-based enumerations in ActiveRecord"
    gemspec.description = <<-EOF
      Extends ActiveRecord with the has_enumeration method that allows an
      attribute to be declared as storing an enumeration.  The enumeration
      is specified as a mapping between symbols and their underlying
      representation in the database.  Predicates are provided for each
      symbol in the enumeration and the symbols may be used in finder methods.
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
    features = %w(explicitly_mapped_enumeration implicitly_mapped_enumeration)
    feature_files = features.map {|f| "features/#{f}.feature"}.join(' ')
    t.cucumber_opts = feature_files
  end

  Cucumber::Rake::Task.new(:rails3) do |t|
    features = %w(arel_attributes)
    feature_files = features.map {|f| "features/#{f}.feature"}.join(' ')
    t.cucumber_opts = feature_files
  end
end
