== Description
This ActiveRecord plugin enables attributes to be declared as enumerations
of symbols.

== Example
class TestObject < ActiveRecord::Base
  # Integer attribute with explicit value mapping
  has_enumeration :color, :red => 1, :green => 2, :blue => 3


  # String attribute with implicit value mapping
  # has_enumeration :color, [:red, :green, :blue]
end

# Value and predicates
obj = TestObject.new
obj.color.value                    # => nil
obj.color = :red                   # => :red
obj.color.value                    # => :red
obj.color.red?                     # => true
obj.color.green?                   # => false

# Querying
TestObject.where(:color => :red)

# Querying with arel predicates (ActiveRecord 3 only)
attr = TestObject.arel_table[:color]
TestObject.where(attr.not_in([:red, :green]))

== Installation
gem install has_enumeration

== Getting the Latest Version
The repository for has_enumeration is hosted at GitHub:
  Web page:   http://github.com/gregspurrier/has_enumeration
  Clone URL:  git://github.com/gregspurrier/has_enumeration.git

== Supported Versions
has_enumeration has been tested with all combinations for the following:

  Rubies:
    - 1.8.7-p302
    - 1.9.2-p0
    - JRuby 1.5.1
  ActiveRecord:
    - 2.3.8
    - 3.0.0.rc
