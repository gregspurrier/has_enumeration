module HasEnumeration
  module ClassMethods
    def has_enumeration(attribute, mapping)
      # ActiveRecord's composed_of method will do most of the work for us.
      # All we have to do is cons up a class that implements the bidirectional
      # mapping described by the provided hash.
      klass = create_enumeration_mapping_class(mapping)

      # Bind the class to a name within the scope of this class
      attribute_name = attribute.to_s
      mapping_class_name = attribute_name.camelize
      const_set(mapping_class_name, klass)
      scoped_class_name = [self.name, mapping_class_name].join('::')

      composed_of(attribute,
        :class_name => scoped_class_name,
        :mapping => [attribute_name, 'raw_value'],
        :converter => :from_sym
      )
    end

  private
    def create_enumeration_mapping_class(mapping)
      inverted_mapping = mapping.invert
      Class.new do
        attr_reader :raw_value, :value

        define_method :initialize do |raw_value|
          @raw_value = raw_value
          @value = inverted_mapping[raw_value]
        end

        mapping.keys.each do |sym|
          predicate = "#{sym}?".to_sym
          value = mapping[sym]
          define_method predicate do
            @raw_value == value 
          end
        end

        (class <<self;self;end).class_eval do
          define_method :from_sym do |sym|
            new(mapping[sym])
          end
        end
      end
    end
  end
end
