# has_enumeration
## Overview
`has_enumeration` adds support for enumerated types to ActiveRecord. The values
of an enumerated attribute are represented as symbols regardless of the
attribute's underlying representation in the database. Predicates
(e.g. `car.color.red?`) are provided for each value of the enumerated type.

## Defining Enumerated Attributes
Enumerated attributes are declared in the model's class definition with the
`has_enumeration` class method.  For example:

    class Car < ActiveRecord::Base
      has_enumeration :color, [:red, :green, :blue]
    end

The above definition assumes that the `color` attribute is stored as a string
and that its values in the database match those obtained by calling `to_s` on
their corresponding symbols. I.e., :red is stored as 'red'.

If the underlying column is not a string or its values do not match the string
version of the enumeration's symbols, then the mapping between symbols and their
underlying values may be provided as a hash:

    class Car < ActiveRecord::Base
      has_enumeration :color, :red => 1, :green => 2, :blue => 3
    end

By default, the underlying attribute is assumed to have the same name as the
enumeration. If this is not the case, the name of the underlying attibute may
be provided with the `:attribute` option:

    class Car < ActiveRecord::Base
      has_enumeration :color, {:red => 1, :green => 2, :blue => 3},
        :attribute => :hue
    end

## Using Enumerated Attributes
### Assignment
Enumerated attributes are assigned using symbols:

    car = Car.new(:color => :red)
    car.color = :blue

The symbols are coerced into an instance of a nested class (`Car::Color` in
this example) that is created by `has_enumeration`. If for some reason you
need to avoid the type coercion, you can assign a value of that class directly:

    car.color = Car::Color.from_sym(:green)

### Querying
When constructing queries referencing the enumerated attribute, use the symbol
as its value:

    Car.find(:all, :conditions => {:color => :red})

`has_enumeration` supports Rails 3 and is aware of the model's underlying Arel
representation:

    Car.where(:color => :red)
    Car.where(Car.arel_table[:color].not_in([:red, :green]))

If you are using MetaWhere, `has_enumeration` plays nicely with it:

    # This example requires the meta_where:
    Car.where(:color.not_in => [:red, :green])

### Testing Values
The primary means of interacting with enumerated attributes is through the
predicate methods that are automatically generated for each value in the
enumeration:

    car = Car.new(:color => :red)
    car.color.red?
    # => true
    car.color.green?
    # => false

If the value of the attribute is needed as a symbol, e.g., for direct
comparison, it can be retrieved with `to_sym`:

    car.color.to_sym
    # => :red

## Installation
`has_enumeration` is packaged as a gem:

    gem install has_enumeration

### Rails 3
To use `has_enumeration` with Rails 3, simply add it to your application's
Gemfile:

    gem 'has_enumeration'

### Rails 2.x
To use `has_enumeration` with Rails 2, add it to your application's
environment.rb file:

    config.gem 'has_enumeration'

## Supported Configurations
`has_enumeration` has been tested with the following versions of ActiveRecord:

* 2.3.10
* 3.0.1
* 3.0.3

and the following Ruby implementations:

* 1.8.7-p302
* 1.9.2-p0
* JRuby 1.5.5
* Rubinius 1.1.0


## Getting the Latest
`has_enumeration` is hosted on github at
[http://github.com/gregspurrier/has_enumeration](http://github.com/gregspurrier/has_enumeration).

You can make a local clone of the repository with the following command:

    git clone git://github.com/gregspurrier/has_enumeration.git

## License
`has_enumeration` is Copyright 2010 by Greg Spurrier. It is released under
the MIT License. Please see LICENSE.txt for details.
