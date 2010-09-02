module HasEnumeration
  module ClassMethods
    def has_enumeration(attribute, mapping)
      unless mapping.is_a?(Hash)
        # Recast the mapping as a symbol -> string hash
        mapping_hash = {}
        mapping.each {|m| mapping_hash[m] = m.to_s}
        mapping = mapping_hash
      end

      # ActiveRecord's composed_of method will do most of the work for us.
      # All we have to do is cons up a class that implements the bidirectional
      # mapping described by the provided hash.
      klass = create_enumeration_mapping_class(mapping)
      attr_enumeration_mapping_classes[attribute] = klass

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

      # Install our aggregate condition handling override, but only once
      unless @aggregate_conditions_override_installed
        extend HasEnumeration::AggregateConditionsOverride
        @aggregate_conditions_override_installed = true
      end

      if respond_to?(:arel_table)
        # Install this attributes mapping for use later when extending
        # Arel attributes on the fly.
        ::Arel::Table.has_enumeration_mappings[table_name][attribute] = mapping
      end
    end

  private
    def attr_enumeration_mapping_classes
      @attr_enumeration_mapping_classes ||= {}
    end

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
