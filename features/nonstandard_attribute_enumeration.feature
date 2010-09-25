Feature:

  As a programmer using an ActiveRecord model with an integer column
  representing an enumerated value
  I want to be able to refer to the enumeration symbolically and have
  predicates to test its value
  So that I can write pretty, concise code.

  Scenario Outline: set an enumerated value on an unsaved object
    Given a model with an nonstandard-attribute enumeration of red, green, and blue
    And an unsaved instance of that model
    When I assign a symbolic value <assigned> to the enumeration
    Then it should have the assigned value as its value
    And the red? predicate should be <red?>
    And the green? predicate should be <green?>
    And the blue? predicate should be <blue?>

    Scenarios: setting various values
      | assigned | red?  | green? | blue? |
      | :red     | true  | false  | false |
      | :green   | false | true   | false |
      | :blue    | false | false  | true  |

  Scenario Outline: set an enumerated value then save and reload
    Given a model with an nonstandard-attribute enumeration of red, green, and blue
    And an unsaved instance of that model
    When I assign a symbolic value <assigned> to the enumeration
    And I save and reload the object
    Then it should have the assigned value as its value
    And the red? predicate should be <red?>
    And the green? predicate should be <green?>
    And the blue? predicate should be <blue?>

    Scenarios: setting various values
      | assigned | red?  | green? | blue? |
      | :red     | true  | false  | false |
      | :green   | false | true   | false |
      | :blue    | false | false  | true  |

  Scenario Outline: find objects with a specific enumerated value
    Given a model with an nonstandard-attribute enumeration of red, green, and blue
    And a set of objects with a variety of values for the enumeration
    When I query for objects with the value <value>
    Then I should get all of the objects having that value
    And I should not get any objects having other values

    Scenarios: querying various values
      | value  |
      | :red   |
      | :green |
      | :blue  |
