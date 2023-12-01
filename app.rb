APP_ROOT = __dir__

require 'debug'
require 'rubygems'
require 'bundler/setup'
require './lib/runner'
Dir['./lib/days/*.rb'].each { |f| require f }
