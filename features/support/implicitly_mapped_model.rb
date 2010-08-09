class ImplicitlyMappedModel < ActiveRecord::Base
  has_enumeration :color, [:red, :green, :blue]
end
