RubyVM::YJIT.enable
APP_ROOT = __dir__

require 'debug'
require 'rubygems'
require 'bundler/setup'
require './lib/runner'
require './lib/bench'
require './lib/util'
Dir['./lib/days/*.rb'].each { |f| require f }
