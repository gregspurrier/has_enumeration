#!/bin/sh
AR_VERSION=3.0.x rvm 1.8.7@ar_3.0.x,1.9.2@ar_3.0.x,jruby@ar_3.0.x,rbx@ar_3.0.x --yaml do rake features spec
AR_VERSION=2.3.10 rvm 1.8.7@ar_2.3.10,1.9.2@ar_2.3.10,jruby@ar_2.3.10,rbx@ar_2.3.10 --yaml do rake features:common spec

