Feature:

  As a programmer using has_enumeration in Rails 3
  I want to be able to refer to the enumeration symbolically when working with
  the underlying arel attributes for a model
  So that I can write pretty, concise code.


  Scenario Outline: find objects with a specific enumerated value via arel
    Given a model with an explicitly-mapped enumeration of red, green, and blue
    And a set of objects with a variety of values for the enumeration
    When I query for objects with the value <value> via arel
    Then I should get all of the objects having that value
    And I should not get any objects having other values

    Scenarios: querying various values
      | value  |
      | :red   |
      | :green |
      | :blue  |
