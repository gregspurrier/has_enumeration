class MappedIntegerModel < ActiveRecord::Base
  #has_enumeration :color, :red => 1, :green => 2, :blue => 3

  class ColorIntegerMap
    attr_reader :raw_value

    MAPPING = {:red => 1, :green => 2, :blue => 3}

    def initialize(value)
      @raw_value = value
    end

    def value
      MAPPING.invert[@raw_value]
    end

    def self.from_sym(sym)
      new(MAPPING[sym])
    end

    def red?
      @raw_value == 1
    end
    
    def green?
      @raw_value == 2
    end

    def blue?
      @raw_value == 3
    end
  end

  composed_of :color,
    :class_name => 'MappedIntegerModel::ColorIntegerMap',
    :mapping => %w(color raw_value),
    :converter => :from_sym
end
