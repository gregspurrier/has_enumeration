module HasEnumeration
  module Arel
    module TableExtensions
      def self.included(base)
        base.class_eval do
          alias_method_chain :attributes, :has_enumeration

          def self.has_enumeration_mappings
            @has_enumeration_mappings ||= Hash.new {|h,k| h[k] = Hash.new}
          end
        end
      end

      def attributes_with_has_enumeration
        return @attributes if @attributes
        attrs = attributes_without_has_enumeration
        mappings = self.class.has_enumeration_mappings[name]
        if mappings
          mappings.each do |attr_name, mapping|
            attr = attrs[attr_name]
            install_has_enumeration_attribute_mapping(attr, mapping)
          end
        end
        attrs
      end

    private
      def install_has_enumeration_attribute_mapping(arel_attr, mapping)
        # For this attribute only, override all of the methods defined
        # in Arel::Attribute::PREDICATES so that they will perform the
        # symbol-to-underlying-value mapping before proceeding with their work.
        (class <<arel_attr;self;end).class_eval do
          define_method :map_enumeration_arg do |arg|
            if arg.is_a?(Symbol)
              unless mapping.has_key?(arg)
                raise ArgumentError.new(
                  "#{arg.inspect} is not one of {#{mapping.keys.map(&:inspect).sort.join(', ')}}"
                )
              end
              mapping[arg]
            elsif arg.is_a?(Array)
              arg.map {|a| map_enumeration_arg(a)}
            else
              arg
            end
          end

          ::Arel::Attribute::PREDICATES.each do |method_name|
            # Preserve the arity of the method we are overriding
            arity = ::Arel::Attribute.instance_method(method_name).arity
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
end
