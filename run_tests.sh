#!/bin/bash

for file in $(ls tests/*); do
  ruby $file
done
