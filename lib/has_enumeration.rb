require 'active_record'

require 'has_enumeration/class_methods'
require 'has_enumeration/aggregate_conditions_override'

# Install our class methods.
ActiveRecord::Base.extend(HasEnumeration::ClassMethods)
