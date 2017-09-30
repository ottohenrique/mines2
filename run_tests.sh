#!/bin/bash

ruby -Ilib -e 'ARGV.each { |f| require f }' ./tests/test*.rb
