class NonstandardAttributeModel < ActiveRecord::Base
  has_enumeration :color, {:red => 1, :green => 2, :blue => 3},
      :attribute => :hue
end
