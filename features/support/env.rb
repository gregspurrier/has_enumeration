$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'has_enumeration'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => File.expand_path('../database', __FILE__)
)

class CreateTables < ActiveRecord::Migration
  create_table :mapped_integer_models, :force => true do |t|
    t.integer :color
  end
end
