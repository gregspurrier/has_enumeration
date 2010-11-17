# Release 1.1
* Support string assignment
  * Intended for bulk assignment from form posts
  * Unlike symbol assignment, will not raise an exception when a value
    is invalid
  * Invalid values will fail validation and add an error on the attribute
* Expose the accepted values for an enumeration via something like
  `Car::Color.values`
