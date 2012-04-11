require 'active_record'

# Install our common ActiveRecord extentions
require 'has_enumeration/class_methods'
ActiveRecord::Base.extend(HasEnumeration::ClassMethods)

# We have two primary use cases, versions of ActiveRecord which define the column mapping in Arel,
# and those which do not.  For ActiveRecord 2.x.x and versions ActiveRecord which rely on
# versions of Arel > 3.0.0, we have column mapping directly in ActiveRecord.
# For the remaining cases, the method of determining column mappings is similar but not identical.
# In general, Arel 2.x.x needs the mapping code described in HasEnumeration::Arel::TableExtensions,
# whereas older versions of Arel need the code in HasEnumeration::Arel::TableExtensionsArelOne.
if ActiveRecord::VERSION::MAJOR >= 3
  if Arel::VERSION >= "3.0.0"
    require 'has_enumeration/aggregate_conditions_override'
  elsif Arel::VERSION >= '2.0.0'
    require 'has_enumeration/arel/table_extensions'
    Arel::Table.send(:include, HasEnumeration::Arel::TableExtensions)
  else
    require 'has_enumeration/arel/table_extensions_arel_one'
    Arel::Table.send(:include, HasEnumeration::Arel::TableExtensionsArelOne)
  end
else
  require 'has_enumeration/aggregate_conditions_override'
end
