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
        # Patch the enumeration's underlying arel attribute to make it
        # aware of the mapping.
        install_arel_attribute_mapping(attribute, mapping)
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

    def install_arel_attribute_mapping(attribute, mapping)
      # For this attribute only, override all of the methods defined
      # in Arel::Attribute::Predications so that they will perform the
      # symbol-to-underlying-value mapping before proceeding with their work.
      arel_attr = arel_table[attribute]
      (class <<arel_attr;self;end).class_eval do
        define_method :map_enumeration_arg do |arg|
          if arg.is_a?(Symbol)
            mapping[arg]
          elsif arg.is_a?(Array)
            arg.map {|a| map_enumeration_arg(a)}
          else
            arg
          end
        end

        Arel::Attribute::Predications.instance_methods.each do |method_name|
          # Preserve the arity of the method we are overriding
          arity = Arel::Attribute::Predications.
            instance_method(method_name).arity
          case arity
          when 1
            define_method method_name do |arg|
              super(map_enumeration_arg(arg))
            end
          when -1
            define_method method_name do |*args|
              super(map_enumeration_arg(args))
            end
          else
            raise "Unexpected arity #{arity} for #{method_name}"
          end
        end
      end
    end
  end
end
