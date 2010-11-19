$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)

require 'has_enumeration'

ActiveRecord::Base.establish_connection(
  :adapter => defined?(JRUBY_VERSION) ? 'jdbcsqlite3': 'sqlite3',
  :database => File.expand_path('../database', __FILE__)
)

if ActiveRecord::VERSION::MAJOR >= 3
  Bundler.require(:meta_where)
end

class CreateTables < ActiveRecord::Migration
  create_table :explicitly_mapped_models, :force => true do |t|
    t.integer :color
  end

  create_table :implicitly_mapped_models, :force => true do |t|
    t.string :color
  end

  create_table :nonstandard_attribute_models, :force => true do |t|
    t.integer :hue
  end
end
