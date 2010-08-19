require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

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
and the symbols may be used in finder methods.  For example:

  class TrafficLight < ActiveRecord::Base
    # Implicit mapping when the attribute is a string storing the string
    # version of the symbol:
    has_enumeration :color, [:red, :yellow, :green]

    # Explicit mappings between symbols and underlying values are also
    # supported.  E.g.:
    #   has_enumeration :color, :red => 1, :yellow => 2, :green => 3
  end

  tl = TrafficLight.new
  tl.color = :red
  tl.color.value          # ==>  :red
  tl.color.red?           # ==>  true
  tl.color.yellow?        # ==>  false

  TrafficLight.all(:conditions => {:color => :red}) # ==> all red traffic lights

When using ActiveRecord 3, the symbolic values can also be used when interacting
with the underlying Arel attributes for a model:

  attr = TrafficLight.arel_table[:color]
  TrafficLight.where(attr.in([:yellow, :green]))  # ==> yellow or green lights

has_enumeration has been tested with:

  Rubies: Ruby 1.8.7, Ruby 1.9.2, and JRuby 1.5.1.
  ActiveRecord: 2.3.8 and 3.0.0.rc
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
