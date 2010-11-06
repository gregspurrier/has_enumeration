ENV['AR_VERSION'] ||= '3.0'

require 'rubygems'
require 'bundler/setup'
require 'rspec'

require File.expand_path('../lib/has_enumeration', File.dirname(__FILE__))
require File.expand_path('../features/support/explicitly_mapped_model', File.dirname(__FILE__))

ActiveRecord::Base.establish_connection(
  :adapter => defined?(JRUBY_VERSION) ? 'jdbcsqlite3': 'sqlite3',
  :database => File.expand_path('../database', __FILE__)
)

if ActiveRecord::VERSION::MAJOR >= 3
  require 'meta_where'
end

class CreateTables < ActiveRecord::Migration
  create_table :explicitly_mapped_models, :force => true do |t|
    t.integer :color
  end
end
