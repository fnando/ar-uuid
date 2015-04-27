require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection 'postgres:///test'

require_relative 'support/matcher'
require_relative 'support/helpers'
require_relative 'support/models'
