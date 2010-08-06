require 'active_record'

require 'has_enumeration/class_methods'

ActiveRecord::Base.extend(HasEnumeration::ClassMethods)
