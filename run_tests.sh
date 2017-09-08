#!/bin/bash

for file in $(ls tests/*); do
  ruby -Ilib:test $file -v
done
