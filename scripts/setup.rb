#! /usr/bin/env ruby

# setup.rb
#
# ensures that all the directories that are needed are in place
# build environments directory (r10k execution)
# creates configs from templates

cwd       = File.expand_path File.dirname(__FILE__)
dirbase   = File.dirname(cwd)

$LOAD_PATH.unshift File.join(dirbase, 'lib')

ARGV.clear

require 'localpuppet'

LocalPuppet.setup
