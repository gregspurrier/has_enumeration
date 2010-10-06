require 'active_record'

# Install our common ActiveRecord extentions
require 'has_enumeration/class_methods'
ActiveRecord::Base.extend(HasEnumeration::ClassMethods)

# For ActiveRecord 3, extend Arel::Table, otherwise we'll need
# our specialization of aggregate_conditions_override
if ActiveRecord::VERSION::MAJOR >= 3
  require 'has_enumeration/arel/table_extensions'
  Arel::Table.send(:include, HasEnumeration::Arel::TableExtensions)
else
  require 'has_enumeration/aggregate_conditions_override'
end
