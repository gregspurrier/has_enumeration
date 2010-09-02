require 'active_record'

require 'has_enumeration/class_methods'
require 'has_enumeration/aggregate_conditions_override'

# Install our ActiveRecord extentions
ActiveRecord::Base.extend(HasEnumeration::ClassMethods)

# If Arel is present, extend it
if defined? Arel::Table
  require 'has_enumeration/arel/table_extensions'
  Arel::Table.send(:include, HasEnumeration::Arel::TableExtensions)
end
