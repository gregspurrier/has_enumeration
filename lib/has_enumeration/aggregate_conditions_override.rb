module HasEnumeration
  module AggregateConditionsOverride
    # Override the aggregate hash conditions behavior to coerce has_enumeration
    # attributes that show up in finder options as symbols into instances of
    # the aggregate class before hash expansion.
    def expand_hash_conditions_for_aggregates(attrs)
      expanded_attrs = attrs.dup
      attr_enumeration_mapping_classes.each do |attr, klass|
        if expanded_attrs[attr].is_a?(Symbol)
          expanded_attrs[attr] = klass.from_sym(expanded_attrs[attr])
        end
      end
      super(expanded_attrs)
    end
  end
end
