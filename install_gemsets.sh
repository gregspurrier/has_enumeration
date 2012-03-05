#!/bin/bash
source ~/.rvm/scripts/rvm
for ruby in 1.8.7 1.9.2 jruby rbx
do
  rvm use $ruby
  for ar_rev in 2.3.10 3.0.x
  do
    gemset=ar_$ar_rev
    echo yes | rvm gemset delete $gemset
    rvm gemset create $gemset
    rvm gemset use $gemset
    AR_VERSION=$ar_rev bundle install
  done
done
