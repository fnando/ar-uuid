# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "bundler/setup"
Bundler.require

require "minitest/utils"
require "minitest/autorun"

ActiveRecord::Base.logger = nil
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection "postgres:///test"

require_relative "support/matcher"
require_relative "support/helpers"
require_relative "support/models"
