# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "has_enumeration"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to?(:required_rubygems_version=)
  s.authors = ["Greg Spurrier"]
  s.date = "2012-04-06"
  s.description = "Extends ActiveRecord with the has_enumeration method allowing a symbolic\nenumeration to be stored in an ActiveRecord attribute.  The enumeration is\nspecified as a mapping between symbols and their underlying representation\nin the database.  Predicates are provided for each symbol in the enumeration\nand the symbols may be used in finder methods.  When using ActiveRecord 3,\nthe symbols may also be used when interacting with the underlying Arel attribute\nfor the enumeration.  has_enumeration has been tested with Ruby 1.8.7,\nRuby 1.9.2, JRuby 1.5.5, Rubinius 1.1.0, ActiveRecord 2.3.10, and ActiveRecord\n3.0.3.\n"
  s.email = "greg@rujubu.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "HISTORY.txt",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "TODO.md",
    "VERSION",
    "all_tests.sh",
    "features/arel_attributes.feature",
    "features/explicitly_mapped_enumeration.feature",
    "features/implicitly_mapped_enumeration.feature",
    "features/meta_where_queries.feature",
    "features/nonstandard_attribute_enumeration.feature",
    "features/step_definitions/has_enumeration_steps.rb",
    "features/support/env.rb",
    "features/support/explicitly_mapped_model.rb",
    "features/support/implicitly_mapped_model.rb",
    "features/support/nonstandard_attribute_model.rb",
    "install_gemsets.sh",
    "lib/has_enumeration.rb",
    "lib/has_enumeration/aggregate_conditions_override.rb",
    "lib/has_enumeration/arel/table_extensions.rb",
    "lib/has_enumeration/arel/table_extensions_arel_one.rb",
    "lib/has_enumeration/class_methods.rb",
    "spec/has_enumeration/has_enumeration_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/gregspurrier/has_enumeration"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.19"
  s.summary = "Support for symbol-based enumerations in ActiveRecord"
  s.specification_version = 3 if s.respond_to?(:specification_version)
  s.add_runtime_dependency(%q<activerecord>, [">= 2.3.10"])
  s.add_runtime_dependency(%q<builder>)
end

